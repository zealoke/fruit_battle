
# Описание

Каждую осень барсуки и еноты собираются на большой поляне в самом сердце леса, чтобы отпраздновать день осеннего солнцестояния.
В честь праздника звери делятся на две команды и устраивают большое веселое сражение, закидывая друг друга печёными яблоками.
После окончания сражения все еноты и барсуки садятся в большой круг, доедают то, что осталось от яблок, поют песни и любуются осенней луной.
Никто не уйдёт обиженным!

## Общие правила

- В состязании всегда сражаются две команды, состоящие из равного количества участников;
- Команда может состоять как полностью из енотов или барсуков, так и иметь произвольный смешанный состав;
- Сражение состоит из раундов. В начале каждого раунда две команды встают друг напротив друга и одновременно кидают печёные яблоки в участников противоположной команды;
- Яблоко всегда попадает в какого-либо зверя и всегда наносит фиксированный урон в 2 условных очка здоровья (HP);
- Каждый зверь (и енот, и барсук) в начале битвы имеют по 10 очков здоровья и таким образом могут выдержать ровно пять попаданий яблоком;
- В конце каждого раунда участники, очки здоровья которых меньше или равны 0, выбывают и досматривают битву в качестве зрителей;
- Команда, которая первой выбила всех участников другой команды, побеждает;
- Если после окончания раунда на поле с обоих сторон не остаётся ни одного участника с HP > 0, то регистрируется ничья;
- Каждый зверь выбирает оппонента для броска яблока совершенно произвольно. Не анализируются ни очки здоровья, оставшиеся у конкретного противника, ни то, куда будут кидать яблоки партнёры по команде. В конкретном раунде может возникнуть ситуация, когда участники команды все разом бросят яблоки в одного оппонента, либо наоборот - когда каждый бросит в разного;
- Так как выбывающие участники определяются только в конце раунда (а не в процессе), нормальной является ситуация, когда какой-либо зверь заканчивает раунд с отрицательными очками здоровья.

## Разница между барсуками и енотами

- Каждый барсук кидает одно яблоко за раунд, и оно всегда попадает в представителя команды противника;
- В отличие от барсуков еноты более хаотичны. В начале каждого раунда енот кидает сразу два яблока обоими лапами. С вероятностью 75% каждое из них попадёт в произвольного участника противоположной команды, и с вероятностью 25% - в произвольного участника своей команды (включая самого енота). Иногда енотам везёт, иногда - не очень. При неудачном стечении обстоятельств оба запущенных яблока могут попасть в самого енота.

# Задача

Ваша задача написать небольшое консольное приложение, которое позволит смоделировать сражение и узнать команду-победителя. Вот несколько основных вопросов, на которые мы хотим ответить:

- Каким является оптимальный состав для варианта с 1,2,3,.. участниками в команде? Можно ли предположить это до проведения численного моделирования?

- Являются ли более результативными однородные или смешанные команды? Почему?

- Меняются ли закономерности формирования оптимальной команды при увеличении числа участников в команде, либо они остаются такими же, как для команды из 1-3 участников?

- Какое количество матчей нужно смоделировать, чтобы получить статистически достоверный результат? Как можно это определить?

# Пример

В качестве примера информации, которую должно выводить и считывать приложение, а также для пояснения самой механики задачи, приведём разбор сражения двух енотов и двух барсуков:

```js
  !!! ДОБРО ПОЖАЛОВАТЬ НА ФРУКТОВУЮ БИТВУ !!!

  Введите количество участников в команде [2]: 2
  Введите количество матчей [10000]: 1
  Подробное логирование [Д]а [Н]ет [Н]: Д

  --- Команда: А ---
  Выберите участника [Е]нот [Б]арсук [Е]: Е
  Выберите участника [Е]нот [Б]арсук [Е]: Е

  --- Команда: Б ---
  Выберите участника [Е]нот [Б]арсук [Б]: Б
  Выберите участника [Е]нот [Б]арсук [Б]: Б

  А ( Ен. Ен. ) VS Б ( Бар. Бар. )

  === Начинаем МАТЧ: 1 ===
  --- Раунд: 1 ---
  Енот [А(1)] кидает яблоко в Барсук [Б(2)]: HP(10) - DM(2) = 8
  Енот [А(1)] кидает яблоко в Енот [А(2)]: HP(10) - DM(2) = 8 (FF!)
  Енот [А(2)] кидает яблоко в Енот [А(2)]: HP(8) - DM(2) = 6 (FF!)
  Енот [А(2)] кидает яблоко в Барсук [Б(2)]: HP(8) - DM(2) = 6
  Барсук [Б(1)] кидает яблоко в Енот [А(2)]: HP(6) - DM(2) = 4
  Барсук [Б(2)] кидает яблоко в Енот [А(2)]: HP(4) - DM(2) = 2


  --- Раунд: 2 ---
  Енот [А(1)] кидает яблоко в Енот [А(2)]: HP(2) - DM(2) = 0 (FF!)
  Енот [А(1)] кидает яблоко в Барсук [Б(2)]: HP(6) - DM(2) = 4
  Енот [А(2)] кидает яблоко в Енот [А(1)]: HP(10) - DM(2) = 8 (FF!)
  Енот [А(2)] кидает яблоко в Барсук [Б(1)]: HP(10) - DM(2) = 8
  Барсук [Б(1)] кидает яблоко в Енот [А(1)]: HP(8) - DM(2) = 6
  Барсук [Б(2)] кидает яблоко в Енот [А(2)]: HP(0) - DM(2) = -2

  Участник Енот [А(2)] выбывает :(

  --- Раунд: 3 ---
  Енот [А(1)] кидает яблоко в Барсук [Б(2)]: HP(4) - DM(2) = 2
  Енот [А(1)] кидает яблоко в Барсук [Б(1)]: HP(8) - DM(2) = 6
  Барсук [Б(1)] кидает яблоко в Енот [А(1)]: HP(6) - DM(2) = 4
  Барсук [Б(2)] кидает яблоко в Енот [А(1)]: HP(4) - DM(2) = 2


  --- Раунд: 4 ---
  Енот [А(1)] кидает яблоко в Енот [А(1)]: HP(2) - DM(2) = 0 (FF!)
  Енот [А(1)] кидает яблоко в Барсук [Б(1)]: HP(6) - DM(2) = 4
  Барсук [Б(1)] кидает яблоко в Енот [А(1)]: HP(0) - DM(2) = -2
  Барсук [Б(2)] кидает яблоко в Енот [А(1)]: HP(-2) - DM(2) = -4

  Участник Енот [А(1)] выбывает :(

  ПОБЕДИТЕЛЬ КОМАНДА: Б ( Бар. Бар. )
  --------------------------------------------------
  Общий победитель: Б! (Процент побед: А ( Ен. Ен. ) = 0%,  Б ( Бар. Бар. ) = 100%, ничьих = 0%)

  Повторить сражение с теми же настройками [Д]а [Н]ет [Д]:

```

## Комментарии

С первого раунда игры становится понятно, что помимо основных правил на поле существуют какие-то внутренние договорённости: все участники с обоих сторон начинают неудержимо кидать яблоки во второго енота команды А. Не совсем понятно, чем енот А(2) это заслужил, но ещё более странно то, что он, поддавшись мнению большинства, также кидает одно из своих яблок сам в себя. В итоге А(2) получает за раунд 4 попадания и теряет 8 HP.

Во втором раунде енот А(1) завершает начатое в предыдущем раунде, выбивая А(2) из игры. Кажется, А(2) был возмущён этим, потому что одно из его яблок полетело обратно в А(1). Судя по всему, еноты совсем не разобрались в правилах игры и барсуки им особенно не нужны.

В третьем раунде енот А(1), к его разочарованию, потерял возможность обстреливать товарищей по команде, а барсуки, довольные сложившимся положением вещей, методично закидывали его яблоками.

В завершающем 4 раунде енот А(1), поняв глубину содеянных ошибок и безвыходность положения, решил совершить "ритуальное самоубийство" своим собственным яблоком. Барсуки закрепили результат и одержали итоговую победу в матче.

## Техническое задание на разрабатываемую программу

### Общие требования к приложению

Приложение должно:

- работать в консольном формате через интерактивное взаимодействие с пользователем;
- быть написано на современной версии языка Delphi в среде Embarcadero (версия Embarcadero Community Edition может быть бесплатно скачана с официального сайта);
- быть написано в парадигме объектно-ориентированного программирования;
- быть готово к условному релизу для пользователей (проверять корректность вводимой пользователем информации, исключать возможность появления необрабатываемых исключений, приводящих к падению программы, и т.д.);
- разработка должна быть размещена в публично доступном git-репозитории.

Примерный ожидаемый объем исходного кода: 500 строк.

### Задание исходной информации

Приложение должно предоставлять возможность:

- ввода количества участников в командах;
- ввода количества моделируемых матчей;
- включения\отключения подробного логирования каждого матча (для возможности единовременного проведения большого количества испытаний и получения статистически значимого результата);
- задания вида каждого конкретного участника в каждой команде (енот или барсук).

### В процессе моделирования

При включённой опции подробного логирования приложение должно выводить информацию о:

- действии каждого участника (Участник X кидает яблоко в участника Y. Исходное количество пунктов HP участника Y, конечное количество пунктов HP участника Y);
- выбывших участниках в конце каждого раунда;
- команде, победившей по итогам конкретного матча.

### Вывод итоговой информации

По результатам проведения заданного количества матчей приложение должно выводить информацию о:

- команде, победившей по результатам всех проведённых матчей;
- проценте побед команды А;
- проценте побед команды Б;
- проценте ничьих.
