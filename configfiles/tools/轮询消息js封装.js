$(function() {
	var loadNotify = function() {
		$.post("/commentary/notify").done(
				function(res) {
					if (res > 0) {
						$("#unreadcount").text(res);
						layer.tips('<a href="/commentary/commentManage">��' + res
								+ '��������</a>', '#unreadcount', {
							tips : [ 3, '#e4e4e4' ]
						});
					}
				}).fail(function() {
			layer.msg("ϵͳ�쳣");
		})
	}

	setInterval(function() {
		loadNotify();
	}, 1000 * 60 * 5);

	loadNotify();
});