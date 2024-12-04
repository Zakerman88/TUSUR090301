program EPKP;
uses crt;
type fonoteka = record //присваиваем fonoteka тип record
     MusicBand: string [30];
     MusicName: string [30];
     Lang: string[15];
     SongDuration: integer;
     Genre: string [15];
     Year: integer;
end;

procedure CreateFile(); //процедура создания файла
  var
  f: file of fonoteka; //файловая переменная
  begin
    clrscr; //очистка экрана
    Assign(f,'Fonoteka.txt'); //связывание переменной с файлом
    Rewrite(f); //создание файла
    Close(f); //закрытие файла
  end;

procedure AddElem(); //процедура добавления элемента
  var
  f: file of fonoteka;
  a: fonoteka;
  size: integer;
  b: integer;
  begin
    clrscr;
    writeln('Введите необходимые данные');
    write('Название исполнителя/группы: ');
    readln(a.MusicBand);
    write('Название произведения: ');
    readln(a.MusicName);
    write('Язык исполнения: ');
    readln(a.Lang);
    write('Продолжительность произведения (в секундах): ');
    readln(a.SongDuration);
    write('Жанр: ');
    readln(a.Genre);
    write('Год выпуска произведения: ');
    readln(a.Year);
    Assign(f,'Fonoteka.txt');
    reset(f); //открытие файла на чтение
    size := FileSize(f); //размер файла
    seek(f, size); //установка указателя на конец файла
    write(f, a); //запись данных в файл
    close(f); //закрытие файла
    clrscr;
  end;

procedure ChangeElem(); //процедура изменения записи
  var
  f: file of fonoteka;
  a: fonoteka;
  size: integer;
  n: integer;
  answer: string;
  begin
    clrscr;
    writeln('Укажите номер изменяемой записи');
    readln (n);
    writeln ('Вы уверены,что хотите изменить ', n, ' элемент из базы данных? (да/нет)');
    repeat
      readln(answer);
      if not (answer = 'да') and not (answer = 'нет')
      then writeln('Введите ответ корректно');
    until (answer = 'да') or (answer = 'нет');
    if (answer = 'да') then
    begin
      writeln('Введите новые данные');
      write('Название исполнителя/группы: ');
      readln(a.MusicBand);
      write('Название произведения: ');
      readln(a.MusicName);
      write('Язык исполнения: ');
      readln(a.Lang);
      write('Продолжительность произведения (в секундах): ');
      readln(a.SongDuration);
      write('Жанр: ');
      readln(a.Genre);
      write('Год выпуска произведения: ');
      readln(a.Year);
      Assign(f,'Fonoteka.txt');
      reset(f);
      seek(f, n-1); //установка указателя на выбранный элемент
      write(f, a);
      close(f);
      clrscr;
    end
    else if (answer = 'нет') then
    begin
      writeln('Изменение отменено');
    end;
  end;

procedure CheckBaza(); //процедура просмотра данных
  var
  f:file of fonoteka;
  r:fonoteka;
  i:integer;
  begin
    clrscr;
    assign(f, 'Fonoteka.txt');
    reset(f);
    while not eof(f) do
    begin
      read(f, r);
      i := i + 1;
      Writeln('№ ', i);
      Writeln ('Название исполнителя/группы: ', r.MusicBand);
      Writeln('Название произведения: ', r.MusicName);
      Writeln('Язык исполнения: ', r.Lang);
      Writeln('Продолжительность произведения: ', r.SongDuration ,' сек');
      Writeln('Жанр: ', r.Genre);
      Writeln('Год выпуска: ', r.Year);
      Writeln();
    end;
    readln;
    close(f);
  end;

procedure DeleteElem(); //процедура удаления записи
  var
  f, g: file of fonoteka;
  a: fonoteka;
  n, i: integer;
  answer: string;
  begin
    clrscr;
    write('Введите номер удаляемой записи:');
    readln(n);
    writeln ('Вы уверены,что хотите удалить ', n, ' элемент из базы данных? (да/нет)');
    repeat
      readln(answer);
      if not (answer = 'да') and not (answer = 'нет')
      then writeln('Введите ответ корректно');
    until (answer = 'да') or (answer = 'нет');
    if (answer = 'да') then
      begin
        assign(f, 'Fonoteka.txt');
        assign(g, 'Delete.txt');
        reset(f);
        rewrite(g);
        while not eof(f) do
          begin
            read(f, a);
            i := i + 1;
            if i <> n then write(g, a);
          end;
        close(f);
        close(g);
        erase(f);
        rename(g, 'Fonoteka.txt');
        writeln('Запись удалена');
        readln;
      end
    else if (answer = 'нет') then
    begin
      writeln('Удаление отменено');
    end
  end;

procedure Sort_Year(); //сортировка по году
  var
  f: file of fonoteka;
  arr: array[1..100] of fonoteka;
  r: fonoteka;
  i, j, k: integer;
  begin
    assign(f, 'Fonoteka.txt');
    reset(f);
    while not eof(f) do
    begin
      i := i + 1;
      read(f, arr[i]); 
    end;
    for k := 1 to i - 1 do
    for j := 1 to i - k do
    begin
      if (arr[j].Year > arr[j + 1].Year) then
      begin
        r := arr[j];
        arr[j] := arr[j + 1];
        arr[j + 1] := r;
      end;
    end;
    clrscr;
    for k := 1 to i do
    begin
      Write('Название исполнителя/группы: ');
      Writeln(arr[k].MusicBand);
      Write('Название произведения: ');
      Writeln(arr[k].MusicName);
      Write('Язык исполнения: ');
      Writeln(arr[k].Lang);
      Write('Продолжительность произведения: ');
      Writeln(arr[k].SongDuration, 'сек');
      Write('Жанр: ');
      Writeln(arr[k].Genre);
      Write('Год выпуска: ');
      Writeln(arr[k].Year);
      Writeln;
    end;
    close(f);
    readln;
  end;

procedure Sort_SongDuration();//сортировка по длительности песни
  var
  f: file of fonoteka;
  arr: array[1..100] of fonoteka;
  r: fonoteka;
  i, j, k: integer;
  begin
    assign(f, 'Fonoteka.txt');
    reset(f);
    while not eof(f) do
    begin
      i := i + 1;
      read(f, arr[i]);
    end;
    for k := 1 to i - 1 do
    for j := 1 to i - k do
    begin
      if (arr[j].SongDuration > arr[j + 1].SongDuration) then
      begin
        r := arr[j];
        arr[j] := arr[j + 1];
        arr[j + 1] := r;
      end;
    end;
    clrscr;
    for k := 1 to i do
    begin
      Write('Название исполнителя/группы: ');
      Writeln(arr[k].MusicBand);
      Write('Название произведения: ');
      Writeln(arr[k].MusicName);
      Write('Язык исполнения: '); 
      Writeln(arr[k].Lang);
      Write('Продолжительность произведения: ');
      Writeln(arr[k].SongDuration, 'сек');
      Write('Жанр: ');
      Writeln(arr[k].Genre);
      Write('Год выпуска: ');
      Writeln(arr[k].Year);
      Writeln;
    end;
    close(f);
    readln;
  end;

procedure Sort(); //процедура вывода меню сортировки
  var
  h:integer;
  begin
    repeat
      ClrScr();
      Writeln('Сортировать по:');
      Writeln('1. Названию исполнителя/группы');
      Writeln('2. Продолжительности произведения');
      Writeln('3. Выход из меню сортировки');
      readln(h);
      case h of //вызов процедуры указанной сортировки
        1: Sort_Year();
        2: Sort_SongDuration();
        3: begin
           end;
      end;
    until h=3;
    Writeln();
  end;

var
c:integer;
begin
  repeat
    clrscr;
    Writeln('Введите пункт меню... ');
    Writeln('1. Создать/пересоздать базу данных');
    Writeln('2. Посмотреть базу данных');
    Writeln('3. Сортировать по критерию...');
    Writeln('4. Добавить запись');
    Writeln('5. Изменить запись');
    Writeln('6. Удалить запись');
    Writeln('7. Завершить сеанс');
    Readln(c); //ввод пункта меню
    case c of //по выбранному пункту вызывается указанная процедура
      1: CreateFile();
      2: CheckBaza();
      3: Sort();
      4: AddElem();
      5: ChangeElem();
      6: DeleteElem();
      7: exit;
    end;
  until c = 7;
end.
