$(function(){
			
			$("#loginBtn").click(function(){
				$("#loginForm").submit();
			});
			
			$("#loginForm").validate({
				errorElement:'span',
				errorClass:'text-danger',
				rules:{
					adminName : {
						required : true
				    }
				}
				messages:{
					adminName : {
						required : "�������û���"
					}
				},
				//���ύ�������Ϊajax�ύ������Դ��ύ��
				submitHandler:function(){
					$.ajax({
						url:"/login",
						type:"post",
						/* data:{
							"adminName":$("#adminName").val(),
							"password":$("#password").val()
						}, */
						data:$("#loginForm").serialize(),//�����ݵ����л���װ ����
						//���ύ���ǰ���ύ��ť��ʽ����
						beforeSend:function(){
							$("#loginBtn").attr("disabled","disabled").text("��¼��...");
						},
						success:function(res){
							if(res.state == "success") {
								//������������ǹ��˵������в�Ϊ��ʱ��ֱ���ض���
								if(callback){
								window.location.href=callback;
								}else{
									window.location.href="/filmList";
								}
								//����¼�ɹ�����ת
							} else {
							//�ύʧ�ܵ�div����չʾ ���������Ա�Ϊ������
								$("#error").text(res.message).show();
							}
						},
						error:function(){
							alert("ϵͳ��æ");
						},
						//�ύ��ɺ�İ�ť��ʽչʾ
						complete:function(){
							$("#loginBtn").removeAttr("disabled").text("�������ϵͳ");
						}
					})
				}
			})
		});