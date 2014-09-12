function sendMail() {
    var link = "mailto:?"
             + "?cc=?"
             + "&subject=" + escape("This is my subject")
             + "&body=" + escape(document.getElementById('#content').value)
    ;

    window.location.href = link;
}
