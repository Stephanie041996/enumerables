module enumerable
    def my_each
       
         if block_given?
          for i in self
           yield i
        
          end
        end
        to_enum
      end
end

