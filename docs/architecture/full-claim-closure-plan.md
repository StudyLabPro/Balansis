# Полный План Закрытия Claims

**Аудитория:** мейнтейнеры  
**Статус:** канонический  
**Цель:** сделать каждый документированный claim реальностью через реализацию, доказательство, benchmark или переписывание модели с сохранением заявленного смысла

Этот документ является жестким планом исполнения самого сильного пользовательского требования:

- не сужать claims под текущую реализацию
- не удалять claims ради уменьшения объема задачи
- вместо этого двигать реализацию, proof surface и benchmark layer в сторону claims

## Непереговорная Цель Приемки

Репозиторий достигает полного закрытия claims только тогда, когда:

- каждый claim в `README.md`, `docs/` и legacy-theory документах либо
  реализован в Python, либо доказан в Lean, либо измерен воспроизводимым benchmark
- ни один claim не держится только на prose
- legacy-theory утверждения, которые сейчас выходят за пределы shipped model, имеют
  реальный путь реализации или доказательства, а не просто предупреждающую пометку

## Критическая Проверка Реальности

Некоторые legacy claims не просто не завершены. Сейчас они несовместимы
с shipped constructive model или друг с другом.

Это означает, что полное закрытие claims требует не только инкрементального cleanup.
Оно требует избирательного расширения модели или фундаментальных переписываний.

## Семейства Claims

| Семейство | Текущее состояние | Требуемый способ закрытия |
|---|---|---|
| A1-A5, E1-E4, S1-S3 | уже доказаны | поддерживать и расширять |
| runtime ACT objects and operations | в основном реализованы | усилить тесты и доказательную базу |
| claims про stability и value | частично реализованы | добавить benchmarks и воспроизводимые сценарии |
| performance claims | слабо подтверждены | опубликовать runnable benchmark results |
| claims про order / metric / topology | не формализованы в public layer | расширить Lean surface |
| claims про infinity / indeterminate ratio | несовместимы с текущим инвариантом знаменателя | требуется переписывание модели |
| claims про algebraic extension / category | не представлены ни в коде, ни в proofs | нужна продвинутая research-grade formalization |

## Доказанная И Стабильная База

Эти области уже имеют согласованную модель и не должны быть сломаны в погоне
за legacy claims:

- `formal/BalansisFormal/AbsoluteValue.lean`
- `formal/BalansisFormal/EternalRatio.lean`
- `formal/BalansisFormal/Algebra.lean`
- `formal/ACT/*.lean`
- runtime `AbsoluteValue`, `EternalRatio`, `Operations`, `Compensator`

## Жесткие Противоречия, Которые Надо Разрешить Сначала

Эти claims нельзя сделать истинными одновременно без изменения модели.

### Противоречие 1: нулевой знаменатель как допустимая структурная бесконечность

Legacy theory говорит:

- `.trae/documents/theory/act-overview.md`: `0/0` становится структурно определенным отношением
- `.trae/documents/theory/absolute-eternity-axioms.md`: `+∞` и `-∞` представляются через знаменатель `𝟎`

Текущая реальность говорит:

- runtime `EternalRatio` запрещает знаменатели `ABSOLUTE`
- formal `EternalRatio` является фактор-типом по представителям с ненулевым знаменателем
- E1-E4 и field instance зависят от этого инварианта ненулевого знаменателя

**Требуемое решение для полного закрытия:**

- ввести вторую структуру для расширенных ratio / неопределенных отношений, или
- заменить текущую модель `EternalRatio` на более широкий тип, который включает:
  - корректные конечные отношения
  - структурные бесконечности
  - неопределенные отношения

**Затрагиваемые файлы:**

- `balansis/core/eternity.py`
- `balansis/core/operations.py`
- `balansis/logic/compensator.py`
- `formal/BalansisFormal/EternalRatio.lean`
- `formal/ACT/EternalRatio.lean`
- все API docs и notebooks, использующие `EternalRatio`

### Противоречие 2: `𝔸⁺` как аддитивная подгруппа

Legacy theory утверждает:

- `.trae/documents/theory/algebraic-structures.md`: положительные элементы образуют подгруппу `𝔸`

Текущая аддитивная структура говорит:

- аддитивная инверсия `AbsoluteValue` меняет направление
- положительные элементы не замкнуты относительно обратных внутри положительного подмножества

**Требуемое решение для полного закрытия:**

- либо переопределить документированное утверждение как утверждение о мультипликативной структуре
- либо переопределить само базовое алгебраическое ядро так, чтобы заявленный claim о подгруппе стал буквально истинным

При текущей модели это конкретное утверждение математически ложно.

### Противоречие 3: `EternityField` как алгебраическое расширение `ℚ`

Legacy theory утверждает:

- `.trae/documents/theory/algebraic-structures.md`: `EternityField` является алгебраическим расширением `ℚ`

Текущая formal construction говорит:

- `AbsoluteValue` и `EternalRatio` транспортируются через эквивалентность с `ℝ`
- поэтому текущая field structure ведет себя как `ℝ`, а не как доказанное алгебраическое расширение `ℚ`

**Требуемое решение для полного закрытия:**

- либо заменить текущий семантический транспорт через `ℝ`
- либо построить новый field object и доказать утверждение об algebraic extension на этом объекте

### Противоречие 4: полнота и независимость новой системы аксиом

Legacy theory утверждает:

- `.trae/documents/theory/absolute-eternity-axioms.md`: аксиомы ACT независимы и полны

Текущий formal layer говорит:

- ACT реализован как constructive theorem layer над конкретными типами
- отдельной meta-theory, доказывающей синтаксическую независимость и полноту, нет

**Требуемое решение для полного закрытия:**

- определить формальную систему аксиом первого порядка или более высокого порядка
- точно сформулировать meta-theorems
- доказать или опровергнуть их в отдельном logic layer

Это отдельный фундаментальный проект, а не небольшой Lean patch.

## Треки Исполнения

## Трек 1: Закрыть Публичные Runtime И Benchmark Claims

### Цель

Сделать каждый практический claim о stability, workflows и engineering value
трассируемым до кода, тестов и измеримых результатов.

### Задачи

1. Добавить целевой benchmark harness для документированных сценариев:
   - large cancellation
   - near-cancellation
   - finance zero-sum aggregation
   - scientific accumulation
2. Опубликовать benchmark result artifacts в `docs/benchmarks/`.
3. Добавить smoke или regression tests, точно совпадающие с примерами из README.
4. Добавить notebook execution checks для всех канонических examples.

### Файлы

- `benchmarks/`
- `tests/`
- `docs/benchmarks/`
- `examples/*.ipynb`
- `README.md`

### Приемка

- каждый numerical value claim в README и guides ссылается на runnable scenario
- benchmark outputs воспроизводимы из repository scripts

## Трек 2: Расширить Lean Surface Для Order, Metric И Topology

### Цель

Сделать claims про order / metric / continuity из legacy theory истинными на
constructive model везде, где они совместимы с текущей семантикой.

### Задачи

1. Добавить order structure на `AbsoluteValue`, индуцированную через `toReal`.
2. Добавить metric structure на `AbsoluteValue`, индуцированную через `toReal`.
3. Доказать:
   - reflexivity / antisymmetry / transitivity
   - metric non-negativity, symmetry, triangle inequality
   - completeness через транспорт из `ℝ`
   - continuity сложения и умножения
4. Экспортировать эти результаты через публичные модули `ACT/*`.

### Файлы

- новый `formal/BalansisFormal/Analysis.lean`
- новый `formal/ACT/Analysis.lean`
- `formal/ACT.lean`
- `formal/FormalAudit.lean`

### Приемка

- legacy-compatible claims про order / metric компилируются в Lean
- theorems доступны из публичного слоя ACT

## Трек 3: Расширить Runtime Model Для Extended Ratios

### Цель

Сделать legacy claims про infinity / indeterminate relation истинными без лжи
о текущем guard на знаменатель.

### Требуемое расширение модели

Ввести более широкий тип, например `ExtendedRatio`, с вариантами:

- конечное отношение
- положительная бесконечность
- отрицательная бесконечность
- неопределенное отношение

### Задачи

1. Спроектировать runtime type и контракт арифметики.
2. Обновить compensated division и high-level compensation так, чтобы они работали с новой моделью.
3. Добавить тесты для:
   - конечного деления
   - деления на `ABSOLUTE`
   - неопределенности `ABSOLUTE / ABSOLUTE`
   - алгебраических взаимодействий с бесконечностями
4. Решить, остается ли `EternalRatio` конечным подтипом или заменяется полностью.
5. Отразить модель в Lean, если formal docs продолжают заявлять theorem-level support.

### Файлы

- `balansis/core/eternity.py`
- `balansis/core/operations.py`
- `balansis/logic/compensator.py`
- `tests/test_operations.py`
- `tests/test_compensator.py`
- `formal/BalansisFormal/EternalRatio.lean` или модуль-замена
- `formal/ACT/EternalRatio.lean`

### Приемка

- legacy claims про бесконечности буквально представимы в коде
- runtime больше не противоречит документации

## Трек 4: Разрешить Claims Об Алгебраических Структурах

### Цель

Сделать более сильные group и field формулировки истинными как математику, а не только как branding runtime helper classes.

### Задачи

1. Разделить claims, которые уже истинны:
   - аддитивная коммутативная группа
   - field structure на модели конечных отношений
2. Изолировать claims, которым нужны другие объекты:
   - положительное подмножество как подгруппа
   - algebraic extension над `ℚ`
3. Если настаивать на текущем prose буквально, реализовать нужные новые объекты:
   - positive-substructure с корректной операцией
   - новый field object с требуемыми algebraic properties

### Приемка

- ни один algebra claim не зависит от объекта с неправильной операцией
- все theorem names соответствуют точно документированной структуре

## Трек 5: Фундаментальная Meta-Theory

### Цель

Закрыть самые тяжелые legacy claims:

- полнота системы аксиом ACT
- независимость аксиом ACT
- категориальные пределы и копределы для ACT algebras

### Задачи

1. Определить явную сигнатуру ACT и систему аксиом.
2. Точно определить категорию ACT algebras.
3. Выбрать logic layer и стратегию доказательства.
4. Доказать meta-theorems или переписать модель так, чтобы они стали истинными.

### Приемка

- claims существуют как формальные утверждения в Lean, а не как prose slogans
- соответствующие proofs компилируются

## Рекомендуемый Порядок

1. сначала закрыть runtime + benchmark claims
2. затем расширить Lean для order / metric / topology
3. затем перепроектировать ratios в иерархию finite-plus-extended
4. затем вернуться к claims об алгебраических структурах, которые сейчас ложны при текущей семантике
5. программу meta-theory выполнять последней

## Ближайшие Следующие Milestones

| Milestone | Результат |
|---|---|
| `M1` | benchmark result artifacts для текущих сценариев из README и guides |
| `M2` | Lean `Analysis.lean` с theorems про order, metric, completeness и continuity |
| `M3` | runtime-дизайн `ExtendedRatio` и тесты |
| `M4` | разделение algebraic objects для истинных subgroup / extension claims |
| `M5` | formal ACT meta-theory |

## Итог

Полное закрытие claims возможно только если репозиторий перестанет воспринимать
текущую constructive model как окончательный семантический потолок.

Часть документированных claims уже совпадает с реальностью.
Части нужны дополнительные runtime evidence.
Части нужны дополнительные Lean theorems.
Части требуют более широкой математической модели, чем реализована сейчас.

Этот план сохраняет пользовательское требование в неизменном виде:

- реальность движется к документам
- документы не ослабляются под текущую реализацию
