# Rezervační systém pro zasedací místnosti

Jednoduchá aplikace v Ruby on Rails vytvořená jako testovací úkol. Umožňuje správu zasedacích místností a jejich rezervaci s hlídáním maximální kapacity.

## 1. Zvolené téma
Vybral jsem si téma **Rezervace zasedacích místností (Meeting rooms)** ve sdíleném kancelářském prostoru. Každá místnost (`Room`) má definovanou maximální kapacitu (počet souběžných míst k sezení). Uživatelé si tvoří rezervace (`Reservation`) na konkrétní čas a zadávají své jméno.

## 2. DECISIONS (Rozhodnutí a architektura)
* **Návrh modelů:** Zvolil jsem minimalistický přístup se dvěma modely - `Room` (zdroj) a `Reservation` (samotná rezervace). Abych aplikaci zbytečně nekomplikoval, nevytvářel jsem model `User` – rezervace je vázána pouze na jméno hosta (`guest_name`).
* **Umístění logiky:** Hlavní algoritmus pro hlídání kapacity jsem umístil přímo do modelu `Reservation` jako custom validaci (`validate :capacity_not_exceeded`). Dodržel jsem tak princip *Fat Model, Skinny Controller* – model sám zodpovídá za konzistenci svých dat před uložením do databáze a controllery zůstávají čisté.
* **Vyhnutí se chybám při editaci:** Ve validaci používám dotaz `where.not(id: id)`. Díky tomu při úpravě (edit) existující rezervace model nepočítá sám sebe jako obsazené místo navíc.
* **UI/UX:** Pro čistý a responzivní vzhled jsem použil Bootstrap 5 přes CDN, abych se vyhnul složité konfiguraci frontendových build nástrojů a splnil požadavek na jednoduchost.

## 3. Proč algoritmus kontroly kapacity funguje
Pro kontrolu kapacity používám efektivní algoritmus zvaný **"Sweep Line"** (zametací přímka). Místo toho, abych kontroloval obsazenost minutu po minutě, načtu si z databáze jen ty rezervace, které se s novou rezervací časově překrývají. Z nich vytvořím časovou osu událostí (příchod = +1 osoba, odchod = -1 osoba), seřadím je chronologicky a následně jimi projdu – pokud běžící součet osob v jakémkoliv bodě překročí povolenou kapacitu místnosti, algoritmus rezervaci zamítne. Zvládá to i těsné návaznosti (když někdo odchází přesně v moment, kdy jiný přichází).

## 4. Co bych udělal jinak, kdybych měl víc času
* **Automatické testy:** Napsal bych RSpec testy, které by detailně prověřily hraniční případy (edge cases) – např. rezervace plně pohlcující jinou rezervaci nebo přesné navazování časů.
* **Vizuální kalendář:** Přidal bych do views javascriptovou knihovnu (např. FullCalendar), aby uživatelé viděli obsazenost místností vizuálně v kalendáři a ne jen v tabulce.
## 5. Jak spustit aplikaci lokálně
Před spuštěním se ujistěte, že máte nainstalované Ruby, Rails a běžící MySQL server. Přístupové údaje k databázi můžete případně upravit v souboru config/database.yml.
* Instalace závislostí:
V terminálu spusťte: **bundle install**
* Příprava databáze:
Tento příkaz automaticky vytvoří databázi, spustí migrace a naplní ji testovacími daty (ze souboru seeds.rb).
V terminálu spusťte: **rails db:setup**
* Spuštění serveru:
V terminálu spusťte: **rails server**
