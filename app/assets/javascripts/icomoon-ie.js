/* Use this script if you need to support IE 7 and IE 6. */

if ($.browser.msie !== undefined) {
  window.onload = function() {
    function addIcon(el, entity) {
      var html = el.innerHTML;
      el.innerHTML = '<span style="font-family: \'icomoon\'">' + entity + '</span>' + html;
    }
    var icons = {
        'icon-victory' : '&#x21;',
        'icon-target' : '&#x22;',
        'icon-target-1' : '&#x23;',
        'icon-message' : '&#x24;',
        'icon-megaphone' : '&#x25;',
        'icon-fire' : '&#x26;',
        'icon-edit' : '&#x27;',
        'icon-cooker' : '&#x28;',
        'icon-close' : '&#x29;',
        'icon-category' : '&#x2a;',
        'icon-close-2' : '&#x2b;',
        'icon-twitter' : '&#x2d;',
        'icon-facebook' : '&#x2c;',
        'icon-mail' : '&#x2e;'
      },
      els = document.getElementsByTagName('*'),
      i, attr, html, c, el;
    for (i = 0; i < els.length; i += 1) {
      el = els[i];
      attr = el.getAttribute('data-icon');
      if (attr) {
        addIcon(el, attr);
      }
      c = el.className;
      c = c.match(/icon-[^\s'"]+/);
      if (c && icons[c[0]]) {
        addIcon(el, icons[c[0]]);
      }
    }
  };
}
