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
    Game.Fight;
    Readln;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
