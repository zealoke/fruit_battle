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
  i,j,k : integer;
  beast : char;

begin
  try
    Writeln('!!! ДОБРО ПОЖАЛОВАТЬ НА ФРУКТОВУЮ БИТВУ !!!');
    Writeln;
    Write('Введите количество участников в команде: ');
    Readln(teamNum);
    Write('Введите количество матчей: ');
    Readln(matches);
    Game := TGameLogic.Create(teamNum, matches);

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

      // играем раунд
      k := 1;
      while (k < 10) do begin
        Writeln('--- Раунд: ',k,' ---');

        Game.Fight; // бой между командами

        // кто выбыл из членов команды А
        for i := 1 to Game.ReturnTeamNum() do
          if Game.NowIsDead(A,i) then Writeln('Участник А',i,' выбывает');
        // кто выбыл из членов команды Б
        for i := 1 to Game.ReturnTeamNum() do
          if Game.NowIsDead(B,i) then Writeln('Участник Б',i,' выбывает');


        k := k + 1;
        Writeln;
        Writeln;
      end;

    end;



    Readln;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
