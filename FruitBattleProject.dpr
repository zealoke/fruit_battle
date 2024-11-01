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
    Writeln;
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
    Writeln;

    // ������ ����
    for j := 1 to Game.ReturnMatchesNum() do begin
      Writeln('=== �������� ����: ',j,' ===');

      // ������ �����
      k := 1;
      while (k < 10) do begin
        Writeln('--- �����: ',k,' ---');

        Game.Fight; // ��� ����� ���������

        // ��� ����� �� ������ ������� �
        for i := 1 to Game.ReturnTeamNum() do
          if Game.NowIsDead(A,i) then Writeln('�������� �',i,' ��������');
        // ��� ����� �� ������ ������� �
        for i := 1 to Game.ReturnTeamNum() do
          if Game.NowIsDead(B,i) then Writeln('�������� �',i,' ��������');


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
