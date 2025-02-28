Для выполнения задания по созданию модуля АЛУ (арифметико-логического устройства) в среде Vivado, следуйте описанным шагам. Ниже приведено пошаговое руководство:

---

### 1. **Создание пакета `alu_opcodes_pkg.sv`**
   - Создайте файл `alu_opcodes_pkg.sv` и добавьте его в проект.
   - В этом файле объявите пакет `alu_opcodes_pkg`, содержащий коды операций АЛУ. Пример:

     ```systemverilog
     package alu_opcodes_pkg;

     // Коды операций АЛУ
     localparam logic [3:0] ALU_ADD  = 4'b0000; // Сложение
     localparam logic [3:0] ALU_SUB  = 4'b0001; // Вычитание
     localparam logic [3:0] ALU_AND  = 4'b0010; // Логическое И
     localparam logic [3:0] ALU_OR   = 4'b0011; // Логическое ИЛИ
     localparam logic [3:0] ALU_XOR  = 4'b0100; // Исключающее ИЛИ
     localparam logic [3:0] ALU_NOT  = 4'b0101; // Логическое НЕ
     localparam logic [3:0] ALU_SHL  = 4'b0110; // Логический сдвиг влево
     localparam logic [3:0] ALU_SHR  = 4'b0111; // Логический сдвиг вправо
     localparam logic [3:0] ALU_SAR  = 4'b1000; // Арифметический сдвиг вправо

     endpackage
     ```

   - Добавьте файл в проект через вкладку **Design Sources**.

---

### 2. **Создание модуля `alu`**
   - Создайте модуль `alu` с портами, указанными в задании. Пример:

     ```systemverilog
     module alu (
         input  logic [31:0] a_i,      // Первый операнд
         input  logic [31:0] b_i,      // Второй операнд
         input  logic [3:0]  alu_op_i, // Код операции АЛУ
         output logic [31:0] result_o, // Результат операции
         output logic        flag_o    // Флаг
     );

     // Импорт пакета с кодами операций
     import alu_opcodes_pkg::*;

     // Внутренние сигналы
     logic [31:0] adder_result; // Результат сложения
     logic [31:0] sub_result;   // Результат вычитания

     // Сложение
     assign adder_result = a_i + b_i;

     // Вычитание
     assign sub_result = a_i - b_i;

     // Мультиплексор для result_o
     always_comb begin
         case (alu_op_i)
             ALU_ADD: result_o = adder_result;
             ALU_SUB: result_o = sub_result;
             ALU_AND: result_o = a_i & b_i;
             ALU_OR:  result_o = a_i | b_i;
             ALU_XOR: result_o = a_i ^ b_i;
             ALU_NOT: result_o = ~a_i;
             ALU_SHL: result_o = a_i << b_i[4:0]; // Сдвиг влево
             ALU_SHR: result_o = a_i >> b_i[4:0]; // Логический сдвиг вправо
             ALU_SAR: result_o = $signed(a_i) >>> b_i[4:0]; // Арифметический сдвиг вправо
             default: result_o = 32'b0;
         endcase
     end

     // Мультиплексор для flag_o
     always_comb begin
         case (alu_op_i)
             ALU_ADD: flag_o = (adder_result == 32'b0); // Флаг нуля для сложения
             ALU_SUB: flag_o = (sub_result == 32'b0);  // Флаг нуля для вычитания
             ALU_AND: flag_o = (result_o == 32'b0);     // Флаг нуля для И
             ALU_OR:  flag_o = (result_o == 32'b0);     // Флаг нуля для ИЛИ
             ALU_XOR: flag_o = (result_o == 32'b0);     // Флаг нуля для XOR
             ALU_NOT: flag_o = (result_o == 32'b0);     // Флаг нуля для НЕ
             ALU_SHL: flag_o = (result_o == 32'b0);     // Флаг нуля для сдвига влево
             ALU_SHR: flag_o = (result_o == 32'b0);     // Флаг нуля для сдвига вправо
             ALU_SAR: flag_o = (result_o == 32'b0);     // Флаг нуля для арифметического сдвига
             default: flag_o = 1'b0;
         endcase
     end

     endmodule
     ```

---

### 3. **Использование сумматора**
   - Для операции сложения используйте 32-битный сумматор, созданный в первой лабораторной работе.
   - Убедитесь, что входной бит переноса (`cin`) установлен в `1'b0`.

---

### 4. **Проверка синтаксиса и компиляция**
   - Убедитесь, что в проекте нет синтаксических ошибок.
   - Если Vivado не может определить порядок компиляции, перейдите на вкладку **Compile Order**, нажмите правой кнопкой мыши на файл `alu_opcodes_pkg.sv` и выберите **Move to Top**.

---

### 5. **Верификация**
   - Используйте тестовое окружение `lab_02.tb_alu.sv` для проверки модуля.
   - Убедитесь, что в **Simulation Sources** выбран правильный модуль верхнего уровня.
   - Запустите моделирование и проверьте, что в TCL-консоли нет ошибок.

---

### 6. **Синтез и реализация в ПЛИС**
   - Запустите синтез и реализацию проекта.
   - Проверьте работоспособность АЛУ на ПЛИС, используя тестовые векторы.

---

### 7. **Отладка**
   - Если возникают ошибки, проверьте:
     - Разрядность сигналов.
     - Корректность подключения сумматора.
     - Правильность использования кодов операций из пакета `alu_opcodes_pkg`.

---

Следуя этим шагам, вы сможете успешно реализовать и протестировать модуль АЛУ в Vivado.
