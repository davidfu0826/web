/*!
 * FileInput <language> Translations - Template file for copying and creating other translations
 *
 * This file must be loaded after 'fileinput.js'. Patterns in braces '{}', or
 * any HTML markup tags in the messages must not be converted or translated.
 *
 * @see http://github.com/kartik-v/bootstrap-fileinput
 *
 * NOTE: this file must be saved in UTF-8 encoding.
 */
(function ($) {
    "use strict";

    $.fn.fileinput.locales.sv = {
        fileSingle: 'fil',
        filePlural: 'filer',
        browseLabel: 'Välj &hellip;',
        removeLabel: 'Ta bort',
        removeTitle: 'Ta bort valda filer',
        cancelLabel: 'Avbryt',
        cancelTitle: 'Avbryt uppladdning',
        uploadLabel: 'Ladda upp',
        uploadTitle: 'Ladda upp valda filer',
        msgSizeTooLarge: 'Filen "{name}" (<b>{size} KB</b>) är större än maxstorleken <b>{maxSize} KB</b>!',
        msgFilesTooLess: 'Du måste välja misnt <b>{n}</b> {files} att ladda upp!',
        msgFilesTooMany: 'Antalet valda filer <b>({n})</b> är fler än max antal tillåtna <b>{m}</b>.!',
        msgFileNotFound: 'Filen "{name}" hittades inte!',
        msgFileSecured: 'Säkerhets begränsningar hindrade "{name}" från att läsas.',
        msgFileNotReadable: 'Filen "{name}" kunde inte läsas.',
        msgFilePreviewAborted: 'Förhandsgranskning avbröts för "{name}".',
        msgFilePreviewError: 'Ett fel uppstod när "{name}" skulle läsas.',
        msgInvalidFileType: 'Otillåten filtyp för "{name}". Bara filtyperna "{types}" är tillåtna.',
        msgInvalidFileExtension: 'Otillåten filtyp för "{name}". Bara filtyperna "{extensions}" är tillåtna.',
        msgValidationError: 'Fel under uppladdningen',
        msgLoading: 'Laddar fil {index} av {files} &hellip;',
        msgProgress: 'Laddar fil {index} av {files} - {name} - {percent}% klar.',
        msgSelected: '{n} filer valda',
        msgFoldersNotAllowed: 'Drag & drop endast för filer! Hoppade över {n} mapp(ar).',
        dropZoneTitle: 'Drag & drop filer här &hellip;'
    };

    $.extend($.fn.fileinput.defaults, $.fn.fileinput.locales.sv);
})(window.jQuery);
