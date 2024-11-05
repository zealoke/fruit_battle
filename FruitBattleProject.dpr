program FruitBattleProject;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  AnimalUnitClass in 'AnimalUnitClass.pas',
  GameLogicUnitClass in 'GameLogicUnitClass.pas';

var
  Game : TGameLogic;
  strTeamNum, strMatches : string;
  teamNum, matches : integer;  
  log : boolean; wrLog : char;  
  beast : char;
  i,j,k : integer;

begin
  try
    Writeln('!!! ДОБРО ПОЖАЛОВАТЬ НА ФРУКТОВУЮ БИТВУ !!!');
    Writeln;
    
    teamNum := 0; strTeamNum := ' ';
    while (teamNum >= CmaxNumMemb) or (teamNum <= 0) do begin
      Write('Введите количество участников в команде (не более 20): ');
      Readln(strTeamNum);
      try
        teamNum := StrToInt(strTeamNum);
      except
        teamNum := 0;
        strTeamNum := ' ';
      end;
    end;    

    matches := 0; strMatches := ' ';
    while (matches >= CmaxMatches) or (matches <= 0) do begin
      Write('Введите количество матчей (не более 1 000 000): ');
      Readln(strMatches);
      try
        matches := StrToInt(strMatches);
      except
        matches := 0;
        strMatches := ' ';
      end;
    end;

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
    Writeln;
    Write('А (');
    for i := 1 to Game.ReturnTeamNum() do 
      case Game.ReturnBeast(A,i) of
        badger  : Write(' Барсук');
        raccoon : Write(' Енот');
      end;
    Write(' ) VS Б (');
    for i := 1 to Game.ReturnTeamNum() do 
      case Game.ReturnBeast(B,i) of
        badger  : Write(' Барсук');
        raccoon : Write(' Енот');
      end;
    Writeln(' )');

    // ИГРАЕМ МАТЧ
    for j := 1 to Game.ReturnMatchesNum() do begin
      Writeln('=== Начинаем МАТЧ: ',j,' ===');
      if Game.ReturnLog() then Writeln;

      // играем раунд
      k := 1;
      while not Game.Stop() do begin
        if Game.ReturnLog() then Writeln('--- Раунд: ',k,' ---');

        Game.Fight(); // бой между командами

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
      if Game.ReturnLog() then
        case Game.ReturnWiner() of
          A    : Writeln('!! Победитель матча: команда А !!');
          B    : Writeln('!! Победитель матча: команда Б !!');
          draw : Writeln('!! Матч закончился НИЧЬЕЙ !!');
        end;
      Writeln;

      // загружаем состав команд из бэкапа
      Game.UnloadTeam();
    end;

    if Game.ReturnStat().A > Game.ReturnStat().B then Writeln('Общий победитель: Команда А');
    if Game.ReturnStat().A < Game.ReturnStat().B then Writeln('Общий победитель: Команда Б');
    if Game.ReturnStat().A = Game.ReturnStat().B then Writeln('Общий победитель: Ничья!');

    Writeln;
    Writeln('=== СТАТИСТИКА МАТЧЕЙ ===');
    Writeln('Команда А: ', (Game.ReturnStat().A/Game.ReturnMatchesNum *100):3:1,' %');
    Writeln('Команда Б: ', (Game.ReturnStat().B/Game.ReturnMatchesNum *100):3:1,' %');
    Writeln('Ничьих:    ', (Game.ReturnStat().draw/Game.ReturnMatchesNum() *100):3:1,' %');

    Readln;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
