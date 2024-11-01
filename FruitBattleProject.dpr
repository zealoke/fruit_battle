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
    Writeln('!!! ����� ���������� �� ��������� ����� !!!');
    Writeln;
    Write('������� ���������� ���������� � �������: ');
    Readln(teamNum);
    Write('������� ���������� ������: ');
    Readln(matches);
    Game := TGameLogic.Create(teamNum, matches);

    Writeln('--- �������: � ---');
    for i := 1 to Game.ReturnTeamNum() do begin
      beast := ' ';
      while (beast <> '�') and (beast <> '�') do begin
        Write('�������� ��������� ',i,' ([�]��� [�]�����): ');
        Readln(beast);
      end;
      case beast of
        '�' : Game.Add(A,i,raccoon);
        '�' : Game.Add(A,i,badger);
      end;
    end;

    Writeln('--- �������: � ---');
    for i := 1 to Game.ReturnTeamNum() do begin
      beast := ' ';
      while (beast <> '�') and (beast <> '�') do begin
        Write('�������� ��������� ',i,' ([�]��� [�]�����): ');
        Readln(beast);
      end;
      case beast of
        '�' : Game.Add(B,i,raccoon);
        '�' : Game.Add(B,i,badger);
      end;
    end;

    Game.CopyToOld(); // ������ ������ �������� ��� �����������
    Game.Fight;
    Readln;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
