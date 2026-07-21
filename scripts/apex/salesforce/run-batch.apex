// Developer Console → Debug → Open Execute Anonymous Window → vlož a spusť.
// scope MUSÍ být 1 (jeden JSON soubor = jedna dávka).
Database.executeBatch(new CermatImportBatch(), 1);
