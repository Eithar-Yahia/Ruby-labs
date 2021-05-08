class ComplexNumber
    @@operation_counter = { total_add: 0,
        total_mult: 0,
        total_bulk_adds: 0,
        total_bulk_mults: 0,
       }
    attr_reader :real, :imagine

    def initialize(real, imagine)
       @real = real
       @imagine = imagine
    end

    def add(cn1)
        @@operation_counter[:total_add] += 1
        result = ComplexNumber.new(real + cn1.real, imagine + cn1.imagine)
        result
    end
    def mul(cn1)
        @@operation_counter[:total_mult] += 1
        real_result = real * cn1.real - imagine * cn1.imagine
        imagine_result = real * cn1.imagine + imagine * cn1.real
        result = ComplexNumber.new(real_result, imagine_result)
        result
    end
    def self.bulk_add(cns)
        @@operation_counter[:total_bulk_adds] += 1
        real_result=0
        imagine_result=0
        cns.each do |cn|
            real_result += cn.real
            imagine_result += cn.imagine
        end
        result = ComplexNumber.new(real_result, imagine_result)
        
    end

    def self.bulk_multiply(cns)
        @@operation_counter[:total_bulk_mults] += 1
        real_result_part1=1
        real_result_part2=1
        imagine_result_part1=1
        imagine_result_part2=1
        for cn in cns
            real_result_part1 *= cn.real
            real_result_part2 *= cn.imagine
            imagine_result_part1 *= cn.real * cn.imagine
            imagine_result_part2 *= cn.imagine * cn.real
        end
        result = ComplexNumber.new(real_result_part1 - real_result_part2, imagine_result_part1 + imagine_result_part2)
        result
    end
    def print 
        puts "#{@real} + #{@imagine}i"
    end

    def self.get_status
        puts "Additions : #{@@operation_counter[:total_add]}"
        puts "Multiplications : #{@@operation_counter[:total_mult]}"
        puts "Bulk adds : #{@@operation_counter[:total_bulk_adds]}"
        puts "Bulk mult : #{@@operation_counter[:total_bulk_mults]}"

    end
end
num1= ComplexNumber.new(1 , 2)
num2= ComplexNumber.new(2 , 4)
num3= ComplexNumber.new(5 , 3)
num4= ComplexNumber.new(4 , 7)
add = num1.add(num2)
add.print
mult= num1.mul(num2)
mult.print


result_bulk_add = ComplexNumber.bulk_add([num1, num2, num3])
result_bulk_add.print


result_bulk_mult= ComplexNumber.bulk_multiply([num1, num2, num3])
result_bulk_mult.print

ComplexNumber.get_status