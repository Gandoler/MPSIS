Для выполнения задачи, описанной в вашем запросе, я предоставлю пример кода на SystemVerilog для реализации пакета `memory_pkg`, памяти инструкций и регистрового файла. Также я дам несколько рекомендаций по проверке и тестированию.

---

### 1. Файл `memory_pkg.sv`
Этот файл содержит объявление пакета с параметрами для памяти инструкций и памяти данных.

```systemverilog
package memory_pkg;

  // Размер памяти инструкций (в словах)
  parameter INSTR_MEM_SIZE = 1024;

  // Размер памяти данных (в словах)
  parameter DATA_MEM_SIZE = 1024;

  // Размер слова (в битах)
  parameter WORD_SIZE = 32;

endpackage
```

---

### 2. Память инструкций
Память инструкций реализуется как массив, где каждая ячейка содержит 32-битное слово. Порт чтения асинхронный.

```systemverilog
module instruction_memory (
  input  logic [31:0] addr,       // Адрес для чтения
  output logic [31:0] instr       // Прочитанная инструкция
);

  // Память инструкций
  logic [31:0] instr_mem [0:memory_pkg::INSTR_MEM_SIZE-1];

  // Асинхронное чтение
  assign instr = (addr < memory_pkg::INSTR_MEM_SIZE) ? instr_mem[addr] : '0;

endmodule
```

---

### 3. Регистровый файл
Регистровый файл содержит 32 регистра, каждый из которых имеет размер 32 бита. Реализованы два порта чтения и один порт записи. Чтение из нулевого регистра всегда возвращает 0.

```systemverilog
module register_file (
  input  logic        clk,        // Тактовый сигнал
  input  logic        rst,        // Сброс
  input  logic        write_en,   // Разрешение записи
  input  logic [4:0]  read_addr1, // Адрес чтения 1
  input  logic [4:0]  read_addr2, // Адрес чтения 2
  input  logic [4:0]  write_addr, // Адрес записи
  input  logic [31:0] write_data, // Данные для записи
  output logic [31:0] read_data1, // Прочитанные данные 1
  output logic [31:0] read_data2  // Прочитанные данные 2
);

  // Регистровый файл
  logic [31:0] rf_mem [0:31];

  // Чтение из регистрового файла
  assign read_data1 = (read_addr1 == 5'b0) ? 32'b0 : rf_mem[read_addr1];
  assign read_data2 = (read_addr2 == 5'b0) ? 32'b0 : rf_mem[read_addr2];

  // Запись в регистровый файл
  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      // Сброс всех регистров в 0
      for (int i = 0; i < 32; i++) begin
        rf_mem[i] <= 32'b0;
      end
    end else if (write_en && write_addr != 5'b0) begin
      // Запись данных, если адрес не равен 0
      rf_mem[write_addr] <= write_data;
    end
  end

endmodule
```

---

### 4. Тестирование
Для тестирования регистрового файла используйте предоставленное верификационное окружение `lab_03.tb_register_file.sv`. Убедитесь, что в Simulation Sources выбран правильный модуль верхнего уровня (например, `tb_register_file`).

Пример команды для запуска моделирования в QuestaSim или Modelsim:
```tcl
vsim work.tb_register_file
run -all
```

---

### 5. Проверка на ПЛИС
Для проверки на ПЛИС:
1. Создайте проект в Quartus или Vivado.
2. Добавьте все необходимые файлы (`memory_pkg.sv`, `instruction_memory.sv`, `register_file.sv`).
3. Назначьте пины и сгенерируйте битстрим.
4. Загрузите битстрим на ПЛИС и проверьте работоспособность.

---

### 6. Рекомендации
- Убедитесь, что все сигналы и параметры соответствуют заданию.
- Проверьте, что чтение из нулевого регистра всегда возвращает 0.
- Убедитесь, что запись в нулевой регистр игнорируется.
- Проверьте, что все тесты в верификационном окружении проходят успешно.

Если возникнут ошибки, внимательно изучите сообщения в TCL-консоли и исправьте соответствующие части кода.
