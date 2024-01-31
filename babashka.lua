-- Программа для проверки, является ли число простым

-- Функция для определения простого числа
function isPrime(number)
    if number <= 1 then
        return false
    end
    for i = 2, number - 1 do
        if number % i == 0 then
            return false
        end
    end
    return true
end

-- Число для проверки
local num = 17

-- Вызов функции и вывод результата
if isPrime(num) then
    print(num .. " является простым числом")
else
    print(num .. " не является простым числом")
end
