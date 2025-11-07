Descrizione. 
NovelArchitect è un’applicazione mobile sviluppata per scrittori che desiderano organizzare in modo strutturato la trama del proprio romanzo prima della stesura vera e propria. L’app consente di gestire capitoli, personaggi, luoghi narrativi, sottotrame e note creative, offrendo uno strumento intuitivo per costruire architetture narrative complesse. Si rivolge in particolare a autori di generi come fantasy, thriller o romanzi corali, dove è fondamentale tenere traccia di molteplici elementi narrativi in modo coerente e accessibile.
Risorse che utilizzerò. 
L’app è sviluppata con Flutter (linguaggio Dart) e utilizza Firebase come backend per il salvataggio persistente e sincronizzato dei dati. I package principali sono:
•	firebase_core: per l’inizializzazione del servizio Firebase;
•	cloud_firestore: per la gestione del database Firestore, dove vengono memorizzati capitoli, personaggi e metadati;
•	image_picker: per consentire all’utente di caricare immagini di luoghi o mappe. Vorrei infatti aggiungere una sezione “Luoghi” in cui l’utente può aggiungere una serie di foto per rendersi conto del contesto ambientale del romanzo;
•	flutter_riverpod: per la gestione reattiva dello stato dell’applicazione;
•	shared_preferences: per memorizzare preferenze locali come il tema o il nome utente.
Context awareness. 
L’app personalizza l’esperienza dell’utente fornendo consigli sul proprio romanzo: per esempio, se è un fantasy, consiglia di guardare determinati film che possano essere d’ispirazione in una sezione presente nel drawer (barra laterale) che si chiama “Suggerimenti d’ispirazione”. Un’altra piccola personalizzazione è nella schermata principale, dove voglio si intraveda il messaggio di “buongiorno” o “buonasera” in base all’ora del giorno + il nome dell’utente. 
Cosa vorrei implementare. 
L’obiettivo è progettare:
-	 la schermata principale, con una barra di navigazione in basso contenente le varie sezioni (Personaggi, Trama e Sinossi, Capitoli, Luoghi), un drawer per Suggerimenti, il Diario, Sinonimi e Note.
-	La schermata che compare quando si clicca una volta selezionato il capitolo su cui lavorare (premendo sulla sezione “Capitoli”), con tutte le informazioni sul capitolo da poter modificare. Quindi, una sottosezione per Personaggi coinvolti, Luogo capitolo, note e obiettivi, Descrizione. 
-	La schermata che compare quando si preme su “Trama e sinossi”, che permette semplicemente di scrivere la trama del romanzo. 

# miarepos
>>>>>>> f2cb857d06b38bbdc3a7bcbca4ecd16dea04871b
