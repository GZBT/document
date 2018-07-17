����jquery��validate.js

���	����	����
1	required:true	����������ֶΡ�
2	remote:"check.php"	ʹ�� ajax �������� check.php ��֤����ֵ��
3	email:true	����������ȷ��ʽ�ĵ����ʼ���
4	url:true	����������ȷ��ʽ����ַ��
5	date:true	����������ȷ��ʽ�����ڡ�����У�� ie6 �������á�
6	dateISO:true	����������ȷ��ʽ�����ڣ�ISO�������磺2009-06-23��1998/01/22��ֻ��֤��ʽ������֤��Ч�ԡ�
7	number:true	��������Ϸ������֣�������С������
8	digits:true	��������������
9	creditcard:	��������Ϸ������ÿ��š�
10	equalTo:"#field"	����ֵ����� #field ��ͬ��
11	accept:	����ӵ�кϷ���׺�����ַ������ϴ��ļ��ĺ�׺����
12	maxlength:5	���볤������� 5 ���ַ�����������һ���ַ�����
13	minlength:10	���볤����С�� 10 ���ַ�����������һ���ַ�����
14	rangelength:[5,10]	���볤�ȱ������ 5 �� 10 ֮����ַ�����������һ���ַ�����
15	range:[5,10]	����ֵ������� 5 �� 10 ֮�䡣
16	max:5	����ֵ���ܴ��� 5��
17	min:10	
����ֵ����С�� 10��



$("#editForm").validate({
			errorElement : 'span',
			errorClass : 'text-danger',
		rules:{
			username : {
				required : true,
				remote:"/user/reg"
			},
			password : {
				required : true
			},
			rePassword : {
				required : true,
				equalTo:$("#password")
			},
			tel : {
				digits:true,
				rangelength:[11,11]
			},
			email : {
				required : true,
				email:true
			}
		},
		messages:{
			username : {
				required : "�������û���",
				remote:"���û����Ѵ���"
			},
			password : {
				required : "����������"
			},
			rePassword : {
				required :"���ٴ���������",
				equalTo:"�����������벻һ��"
			},
			tel:{
			    digits:"ֻ����������Ŷ",
			    rangelength:"������11λ�ֻ�����"
			},
			email : {
				required :"����������",
				email:"����������ȷ��ʽ�ĵ����ʼ���"
			}
		},
			errorPlacement : function(error, element) {
				//��ʾ������Ϣ��ŵ�λ�� ��ʾ����ڵ�ǰԪ�صĸ�Ԫ���к�
				error.appendTo(element.parent());
			},
		});