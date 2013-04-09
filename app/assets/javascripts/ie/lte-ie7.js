/* Load this script using conditional IE comments if you need to support IE 7 and IE 6. */

window.onload = function() {
	function addIcon(el, entity) {
		var html = el.innerHTML;
		el.innerHTML = '<span style="font-family: \'entypo\'">' + entity + '</span>' + html;
	}
	var icons = {
			'icon-pencil' : '&#xe001;',
			'icon-export' : '&#xe000;',
			'icon-thumbs-up' : '&#xe002;',
			'icon-thumbs-down' : '&#xe003;',
			'icon-star' : '&#xe004;',
			'icon-download' : '&#xe005;',
			'icon-target' : '&#xe006;',
			'icon-mail' : '&#xe007;',
			'icon-megaphone' : '&#xe008;',
			'icon-new' : '&#xe009;',
			'icon-cross' : '&#xe00a;',
			'icon-list' : '&#xe00b;',
			'icon-chat' : '&#xe00c;',
			'icon-user' : '&#xe00d;',
			'icon-facebook' : '&#xe00e;',
			'icon-twitter' : '&#xe00f;'
		},
		els = document.getElementsByTagName('*'),
		i, attr, html, c, el;
	for (i = 0; ; i += 1) {
		el = els[i];
		if(!el) {
			break;
		}
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