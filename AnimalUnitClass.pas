unit AnimalUnitClass;


interface

uses
  System.SysUtils;

const
  CmaxNumMemb = 20; // ������������ ���������� ������ � �������

type
  TAnimal = Class; // ��������������� ������
  TAnimalTeam = array [1..CmaxNumMemb] of TAnimal;

  // ����� ������ �����: ������, ����
  TBeast = (badger, raccoon);

  // ������� ����� ������
  TAnimal = Class(TObject)
    private
      hp       : integer;
      attacked : boolean;
      alive    : boolean;
      beast    : TBeast;
      procedure Damage();
    public
      constructor Create(beast : TBeast); overload;
      function ReturnHP(): integer;
      function IsAttacked(): boolean;
      function IsAlive(): boolean;
      procedure Attack(numMemb : integer; // ���������� ������ � ��������
//                     ���������,   ��������
                       rivalsArray, alliesArray : TAnimalTeam);
      procedure ResetDamage();
      procedure IsDead();
  End;


implementation


{ TAnimal }

constructor TAnimal.Create(beast : TBeast);
begin
  self.hp       := 10;
  self.attacked := FALSE;
  self.alive    := TRUE;
  self.beast    := beast;
end;

procedure TAnimal.Damage;
begin
  self.hp       := self.hp - 2;
  self.attacked := TRUE;
end;

procedure TAnimal.ResetDamage;
begin
  self.attacked := FALSE;
end;

function TAnimal.ReturnHP: integer;
begin
  ReturnHP := self.hp;
end;

function TAnimal.IsAlive: boolean;
begin
  IsAlive := self.alive;
end;

function TAnimal.IsAttacked: boolean;
begin
  IsAttacked := self.attacked;
end;

procedure TAnimal.Attack;
var
  chance : integer;
  apple  : integer;
  i      : integer;
begin
  case self.beast of
    // ���� ��������� - ������
    badger :
      begin
        apple := 1 + Random(numMemb);
        while not rivalsArray[apple].IsAlive do apple := 1 + Random(numMemb);
        rivalsArray[apple].Damage;
      end;
    // ���� ��������� - ����
    raccoon :
      for i := 1 to 2 do begin // ���� ������ ��� ������
        chance := 1 + Random(4);
        if (chance <= 3) then
          begin
            apple := 1 + Random(numMemb);
            while not rivalsArray[apple].IsAlive do apple := 1 + Random(numMemb);
            rivalsArray[apple].Damage;
          end
          else begin
            apple := 1 + Random(numMemb);
            while not alliesArray[apple].IsAlive do apple := 1 + Random(numMemb);
            alliesArray[apple].Damage;
          end;
      end;
  end;
end;

procedure TAnimal.IsDead;
begin
  if (self.hp <= 0) then self.alive := FALSE;
end;

end.
