program FruitBattleProject;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  AnimalUnitClass in 'AnimalUnitClass.pas',
  GameLogicUnitClass in 'GameLogicUnitClass.pas';

var
  Game : TGameLogic;
  teamNum, matches : integer;
  log : boolean;
  stat : TStat;
  i,j,k : integer;
  beast,wrLog : char;

begin
  try
    Writeln('!!! ДОБРО ПОЖАЛОВАТЬ НА ФРУКТОВУЮ БИТВУ !!!');
    Writeln;

    Write('Введите количество участников в команде: ');
    Readln(teamNum);

    Write('Введите количество матчей: ');
    Readln(matches);

    log := FALSE; wrLog := ' ';
    while (wrLog <> 'Д') and (wrLog <> 'Н') do begin
        Write('Включить подробное логирование ([Д]а [Н]ет): ');
        Readln(wrLog);
    end;
    if (wrLog = 'Д') then log := TRUE;
    Game := TGameLogic.Create(teamNum, matches, log);

    Writeln('--- Команда: А ---');
    for i := 1 to Game.ReturnTeamNum() do begin
      beast := ' ';
      while (beast <> 'Е') and (beast <> 'Б') do begin
        Write('Выберите участника ',i,' ([Е]нот [Б]арсук): ');
        Readln(beast);
      end;
      case beast of
        'Е' : Game.Add(A,i,raccoon);
        'Б' : Game.Add(A,i,badger);
      end;
    end;
    Writeln;
    Writeln('--- Команда: Б ---');
    for i := 1 to Game.ReturnTeamNum() do begin
      beast := ' ';
      while (beast <> 'Е') and (beast <> 'Б') do begin
        Write('Выберите участника ',i,' ([Е]нот [Б]арсук): ');
        Readln(beast);
      end;
      case beast of
        'Е' : Game.Add(B,i,raccoon);
        'Б' : Game.Add(B,i,badger);
      end;
    end;

    Game.CopyToOld(); // состав команд сохранен для перезапуска
    Writeln;

    // ИГРАЕМ МАТЧ
    for j := 1 to Game.ReturnMatchesNum() do begin
      Writeln('=== Начинаем МАТЧ: ',j,' ===');
      if Game.ReturnLog() then Writeln;

      // играем раунд
      k := 1;
      while not Game.Stop() do begin
        if Game.ReturnLog() then Writeln('--- Раунд: ',k,' ---');

        Game.Fight; // бой между командами

        // кто выбыл из членов команды А
        for i := 1 to Game.ReturnTeamNum() do
          if Game.NowIsDead(A,i) then
            if Game.ReturnLog() then Writeln('Участник А',i,' выбывает');
        // кто выбыл из членов команды Б
        for i := 1 to Game.ReturnTeamNum() do
          if Game.NowIsDead(B,i) then
            if Game.ReturnLog() then Writeln('Участник Б',i,' выбывает');

        k := k + 1;
        if Game.ReturnLog() then Writeln;
      end;

      // определяем команду победителя матча
      if Game.ReturnLog then
        case Game.ReturnWiner of
          A    : Writeln('!! Победитель матча: команда А !!');
          B    : Writeln('!! Победитель матча: команда Б !!');
          draw : Writeln('!! Матч закончился НИЧЬЕЙ !!');
        end;
      Writeln;

      // загружаем состав команд из бэкапа
      Game.ReturnTeam;
    end;

    stat := Game.ReturnStat();
    if stat.A > stat.B then Writeln('Общий победитель: Команда А');
    if stat.A < stat.B then Writeln('Общий победитель: Команда Б');
    if stat.A = stat.B then Writeln('Общий победитель: Ничья!');

    Writeln;
    Writeln('=== СТАТИСТИКА МАТЧЕЙ ===');
    Writeln('Команда А: ', (stat.A/Game.ReturnMatchesNum *100):3:1,' %');
    Writeln('Команда Б: ', (stat.B/Game.ReturnMatchesNum *100):3:1,' %');
    Writeln('Ничьих:    ', (stat.draw/Game.ReturnMatchesNum *100):3:1,' %');

    Readln;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
