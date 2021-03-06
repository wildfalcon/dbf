module DBF
  
  # An instance of DBF::Record represents a row in the DBF file 
  class Record
    attr_reader :attributes
    attr_reader :memo_block_size
    
    delegate :columns, :to => :@table
    
    # Initialize a new DBF::Record
    # 
    # @param [DBF::Table] table
    def initialize(table)
      @table, @data, @memo = table, table.data, table.memo
      @memo_block_size = @table.memo_block_size
      initialize_values
      define_accessors
    end
    
    # Equality
    #
    # @param [DBF::Record] other
    # @return [Boolean]
    def ==(other)
      other.respond_to?(:attributes) && other.attributes == attributes
    end
    
    # Maps a row to an array of values
    # 
    # @return [Array]
    def to_a
      columns.map { |column| @attributes[column.name.underscore] }
    end
    
    private
    
    # Defined attribute accessor methods
    def define_accessors
      columns.each do |column|
        underscored_column_name = column.name.underscore
        unless respond_to?(underscored_column_name)
          self.class.send :define_method, underscored_column_name do
            @attributes[column.name.underscore]
          end
        end
      end
    end
    
    # Initialize values for a row
    def initialize_values
      @attributes = columns.inject({}) do |hash, column|
        if column.type == 'M'
          memo = read_memo(get_starting_block(column))
          hash[column.name] = memo
          hash[column.name.underscore] = memo
        else
          value = unpack_data(column.length)
          type_cast_value = column.type_cast(value)
          hash[column.name] = type_cast_value
          hash[column.name.underscore] = type_cast_value
        end
        hash
      end
    end
   
    # Unpack starting block from database
    #
    # @param [Fixnum] length
    def get_starting_block(column)
      if %w(30 31).include?(@table.version)
        @data.read(column.length).unpack('V')[0]
      else
        unpack_data(column.length).to_i
      end
    end

    # Unpack raw data from database
    # 
    # @param [Fixnum] length
    def unpack_data(length)
      @data.read(length).unpack("a#{length}").first
    end
    
    # Reads a memo from the memo file
    # 
    # @param [Fixnum] start_block
    def read_memo(start_block)
      return nil if !@table.has_memo_file? || start_block < 1

      @table.memo_file_format == :fpt ? build_fpt_memo(start_block) : build_dbt_memo(start_block)
    end
    
    # Reconstructs a memo from an FPT memo file
    #
    # @param [Fixnum] start_block
    # @return [String]
    def build_fpt_memo(start_block)
      @memo.seek(start_block * memo_block_size)
      
      memo_type, memo_size, memo_string = @memo.read(memo_block_size).unpack("NNa*")
      return nil unless memo_type == 1 and memo_size > 0
      
      if memo_size > memo_block_content_size
        memo_string << @memo.read(memo_content_size(memo_size))
      else
        memo_string = memo_string[0, memo_size]
      end
      memo_string.strip
    end
    
    # Reconstucts a memo from an DBT memo file
    # 
    # @param [Fixnum] start_block
    # @return [String]
    def build_dbt_memo(start_block)
      @memo.seek(start_block * memo_block_size)
      
      case @table.version
      when "83" # dbase iii
        memo_string = ""
        loop do
          block = @memo.read(memo_block_size)
          memo_string << block
          break if block.rstrip.size < memo_block_size
        end
      when "8b" # dbase iv
        memo_type, memo_size = @memo.read(BLOCK_HEADER_SIZE).unpack("LL")
        memo_string = @memo.read(memo_size)
      end
      memo_string
    end
    
    # The size in bytes of the content for each memo block
    # 
    # @return [Fixnum]
    def memo_block_content_size
      memo_block_size - BLOCK_HEADER_SIZE
    end
    
    # The size in bytes of the entire memo
    #
    # @return [Fixnum]
    def memo_content_size(memo_size)
      (memo_size - memo_block_size) + BLOCK_HEADER_SIZE
    end
    
  end
end