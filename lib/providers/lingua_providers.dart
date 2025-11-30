// lib/providers/lingua_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/lingua_model.dart';

class LinguaProvider with ChangeNotifier {
  Lingua _linguaCorrente = Lingua.lingueSupportate[0]; // Italiano di default

  Lingua get linguaCorrente => _linguaCorrente;

  // Carico la lingua salvata all'avvio
  Future<void> caricaLinguaSalvata() async {
    final prefs = await SharedPreferences.getInstance();
    final codiceSalvato = prefs.getString('lingua') ?? 'it';

    _linguaCorrente = Lingua.daCodice(codiceSalvato);
    notifyListeners();
  }

  // Cambia lingua e salva
  Future<void> cambiaLingua(Lingua nuovaLingua) async {
    _linguaCorrente = nuovaLingua;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lingua', nuovaLingua.codice);

    notifyListeners(); // Aggiorna tutta l'app
  }

  // Metodo per tradurre i testi (semplificato)
  String traduci(String chiave) {
    // Mappa delle traduzioni
    final mappature = {
      'it': {
        'app_title': 'NovelArchitect',
        'Home': 'Home',
        'Personaggi': 'Personaggi',
        'Trama e Sinossi': 'Trama e Sinossi',
        'Capitoli': 'Capitoli',
        'Luoghi': 'Luoghi',
        'Impostazioni': 'Impostazioni',
        'salva': 'Salva',
        'aggiungi': 'Aggiungi',
        'Dettaglio Capitolo': 'Dettaglio Capitolo',
        'Salva':'Salva',
        'Titolo Capitolo':'Titolo Capitolo',
        'Descrizione':'Descrizione',
        'Personaggi Coinvolti (separati da virgola)':'Personaggi Coinvolti (separati da virgola)',
        'Luogo del capitolo':'Luogo del capitolo',
        'Note Creative':'Note Creative',
        'Obiettivi del Capitolo':'Obiettivi del Capitolo',
        //in home_screen
        'Inizia a scrivere!':'Inizia a scrivere',
        'Buongiorno':'Buongiorno',
        'Buon Pomeriggio':'Buon Pomeriggio',
        'Buonasera':'Buonasera',
        //impostazioni
        ' Altre impostazioni':'Altre informazioni',
        //sezione capitoli
        'nessun_capitolo': 'Nessun capitolo ancora creato',
        'nuovo_capitolo': 'Nuovo Capitolo',
        'crea_capitolo': 'Crea Capitolo',
        'annulla': 'Annulla',
        //in trama e sinossi
        'Trama e sinossi salvate!':'Trama e sinossi salvate!',
        'Trama Completa':'Trama Completa',
        'Sinossi':'Sinossi',
        'Scrivi qui la tua trama...':'Scrivi qui la tua trama...',
        'Parole':'Parole',
        'Scrivi qui la sinossi...':'Scrivi qui la sinossi...',
        'Scrivi qui la trama completa del tuo romanzo...':'Scrivi qui la trama completa del tuo romanzo...',
        'Scrivi qui la sinossi (max 500 parole)...':'Scrivi qui la sinossi (max 500 parole)...',
        'NovelArchitect: la tua app da scrittore!':'NovelArchitect:la tua app da scrittore!',
      },
      'en': {
        'app_title': 'NovelArchitect',
        'Home': 'Home',
        'Personaggi': 'Characters',
        'Trama e Sinossi': 'Plot and Synopsis',
        'Capitoli': 'Chapters',
        'Luoghi': 'Locations',
        'Impostazioni': 'Settings',
        'Salva': 'Save',
        'aggiungi': 'Add',
        'Dettaglio Capitolo': 'Chapter Detail',

        'Titolo Capitolo':'Chapter Title',
        'Descrizione':'Description',
        'Personaggi Coinvolti (separati da virgola)':'Characters involved(depareted by commas)',
        'Luogo del capitolo':'Location of the chapter',
        'Note Creative':'Creative Notes',
        'Obiettivi del Capitolo':'Chapter objectives',
        //in home_screen
        'Buongiorno':'Good Morning',
        'Buon Pomeriggio':'Good afternoon',
        'Buonasera':'Good evening',
        'Inizia a scrivere!':'Start to write',
        //impostazioni
        ' Altre impostazioni':'More info',
        //sezione capitoli
        'nessun_capitolo': 'No chapters created yet',
        'nuovo_capitolo': 'New Chapter',
        'crea_capitolo': 'Create Chapter',
        'annulla': 'Cancel',
        //in trama e sinossi
        'Trama e sinossi salvate!':'Saved plot and synopsis!',
        'Trama Completa':'Full plot',
        'Sinossi':'Synopsis',
        'Scrivi qui la tua trama...':'Write your plot here...',
        'Parole':'Words',
        'Scrivi qui la sinossi...':'Write here your synopsis...',
        'Scrivi qui la trama completa del tuo romanzo...':'Write your full plot here...',
        'Scrivi qui la sinossi (max 500 parole)...':'Write your synopsis here(max 500 words)...',
        'NovelArchitect: la tua app da scrittore!':'NovelArchitect: Your application to write!',

      },
      'es': {
        'app_title': 'NovelArchitect',
        'Home': 'Inicio',
        'Personaggi': 'Personajes',
        'Trama e Sinossi': 'Trama y Sinopsis',
        'Capitoli': 'Capítulos',
        'Luoghi': 'Lugares',
        'Impostazioni': 'Configuración',
        'Salva': 'Guardar',
        'aggiungi': 'Añadir',
        'Dettaglio Capitolo':'detalle del capìtulo',
        'Titolo Capitolo':'titulo del capitulo',
        'Descrizione':'Descripciòn',
        'Personaggi Coinvolti (separati da virgola)':'Caracters involucrados (separados por commas)',
        'Luogo del capitolo':'ubication del capitulo',
        'Note Creative':'Notas Creativas',
        'Obiettivi del Capitolo':'Objetivos del capitulo',
        //in home_screen
        'Buongiorno':'Buenos dias',
        'Buon Pomeriggio':'Buenas tardes',
        'Buonasera':'Buenas noches',
        'Inizia a scrivere!':'empezar a escribir',
        //impostazioni
        ' Altre impostazioni':'Mas Informacion',
        // in sezione_capitoli
        'nessun_capitolo': 'No hay capítulos creados aún',
        'nuovo_capitolo': 'Nuevo Capítulo',
        'crea_capitolo': 'Crear Capítulo',
        'annulla': 'Cancelar',
        //in trama e sinossi
        'Trama e sinossi salvate!':'Trama y sinopsis guardadas!',
        'Trama Completa':'Trama guardadas',
        'Sinossi':'Sinopsis',
        'Scrivi qui la tua trama...':'Escribe tu trama aqui...',
        'Parole':'Parabras',
        'Scrivi qui la sinossi...':'Escribe tu sinopsas aqui...',
        'Scrivi qui la trama completa del tuo romanzo...':'Escribe tu trama completa aqui...',
        'Scrivi qui la sinossi (max 500 parole)...':'Escribe tu sinopsas aqui (maximo 500 parabras)...',
        'NovelArchitect: la tua app da scrittore!':'NovelArchitect: tu aplicacion de escritura!',

      },
      'fr': {
        'app_title': 'NovelArchitect',
        'Home': 'Accueil',
        'Personaggi': 'Personnages',
        'Trama e Sinossi': 'Intrigue et Synopsis',
        'Capitoli': 'Chapitres',
        'Luoghi': 'Lieux',
        'Impostazioni': 'Paramètres',
        'Salva': 'Sauvegarder',
        'aggiungi': 'Ajouter',
        'Dettaglio Capitolo':'détail du chapitre',
        'Titolo Capitolo':'titre du chapitre',
        'Descrizione':'Description',
        'Personaggi Coinvolti (separati da virgola)':'Personagges impliques (separes par des virgules)',
        'Luogo del capitolo':'emplacement du chapitre',
        'Note Creative':'Notes Creatives',
        'Obiettivi del Capitolo':'Objectives du capitre',
        //in home_screen
        'Buongiorno':'Bonjour',
        'Buon Pomeriggio':'Bon apres-midi',
        'Buonasera':'Bonsoir',
        'Inizia a scrivere!':'commencer a ecrire',
        //impostazioni
        ' Altre impostazioni':'plus d informations',
        //in sezione capitoli
        'nessun_capitolo': 'Aucun chapitre créé pour le moment',
        'nuovo_capitolo': 'Nouveau Chapitre',
        'crea_capitolo': 'Créer le Chapitre',
        'annulla': 'Annuler',
        //in trama e sinossi
        'Trama e sinossi salvate!':'Intrigue et synopsis enregistres!',
        'Trama Completa':'intrigue complete',
        'Sinossi':'Synopsis',
        'Scrivi qui la tua trama...':'Ecrivez votre intrigue ici...',
        'Parole':'Mots',
        'Scrivi qui la sinossi...':'Ecrivez votre synopsis ici...',
        'Scrivi qui la trama completa del tuo romanzo...':'Ecrivez votre intrigue complete ici...',
        'Scrivi qui la sinossi (max 500 parole)...':'Ecrivez votre synopsis ici( 500 mots maximum)...',
        //layout
        'NovelArchitect: la tua app da scrittore!':'NovelArchitect: votre application d/ecriture!',
      },
    };

    return mappature[_linguaCorrente.codice]?[chiave] ?? chiave;
  }
}