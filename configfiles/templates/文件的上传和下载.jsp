�����ļ��ı����ύ���ļ����ϴ�����
 1.���ύ������post 
 2.���������� enctype="multipart/form-data"
 3.��ͨ���ݵ�input Ĭ��name����desc
 4.�ļ���input name���Ա����� file
 5.servlet���ն˲���web�˵�Ӱ��
 
 
 <form action="/upload3" method="post" enctype="multipart/form-data">
<input type="text" name="desc" /><br /> 
<input type="file" name="file" />
<button>��ʼ�ϴ�</button>
</form>

<img src="/download?file=c5724829-8d04-4c72-9c94-da64460cb5f2.jpg" height="200" alt="">
<a href="/download?file=c5724829-8d04-4c72-9c94-da64460cb5f2.jpg&name=you.jpg">������Ƭ</a>
<a href="/download?file=�ҵ���Ƭ.jpg">�����ҵ���Ƭ</a>
<a href="/download?file=my.pdf">����PDF�ļ�</a>
<a href="/download?file=commons-collections4-4.1-bin.zip">����zip�ļ�</a>



ʹ��webuploader�ύ�����ļ�����
1.���� /static/bootstrap/css/bootstrap.css 
2.����/static/plugins/uploader/webuploader.css
3.����/static/dist/js/jquery3.js
4.����/static/plugins/uploader/webuploader.js
<div id="picker">�ļ��ϴ�</div> // �����ļ��ϴ���ť


   $(function(){
             //���ı������ͼƬ
         var editor = new Simditor({
			textarea : $('#editor'),
			//��Ӳ���ͼƬ����
			upload:{
				url:"/img/uploader",//ָ��ͼƬ�ϴ��ķ���
				fileKey:"file"
			}
		});
    	 //��ʼ��webuploader 
        var uploader= WebUploader.create({
    	swf: '/static/plugins/uploader/Uploader.swf',//ָ��ʹ��flash�ϴ��Ĳ��
    	server:"upload3",//�ļ��ϴ��ķ���·��
    	pick:'#picker',//�ϴ���ť ����ѡ���ļ�����
    	auto:'true',//�Ƿ��Զ��ϴ�
    	fileNumLimit:"1",//ֻ�����ϴ�һ��ͼƬÿ��
    	//ֻ����ѡ��ͼƬ�ļ���
    	 accept:{
    		title:'Images',
    		extensions:'gif,jpg,png,jpeg',
    		mimeTypes:'image/*'//mime����
    	} 
    }); 
    	// �����ļ�����ӽ����е�ʱ�򣨿�ѡ ��ҳ���Ͽ��������ص�div��
		uploader.on('fileQueued', function(file) {
			$("#fileList").append(
    			'<div id="' + file.id + '" class="item">'
    					+ '<h4 class="info">' + file.name + '</h4>'
    					+ '</div>');
		});
    	 //�ļ����ϴ�����
    	 uploader.on("uploadProgress",function(file,percentage){
    		 $("#span").text(parseInt(percentage*100)+"%");
    	 });
    	 //�ļ��ϴ��ɹ���ͬ��ӵ���˳ɹ�����Ӧ���ݣ�
    	 uploader.on("uploadSuccess",function(file,resp){
		//�������ļ��������� ��ӵ�ָ��λ��ͼƬsrc�� ʵ��ͼƬ��Ԥ��
		//file_path��success �Ǹ��ı������ajax��Ӧ�ĸ�ʽ�����Զ���ͼƬfile_path ��ӵ�src �ڲ��벿λ��ʾ
		//servlet�������ݸ�ʽ�Ը��ı���Ϊ ��׼
    	  $("#img").attr("src", resp.file_path);
    	    
    	//�����ɵ�Ψһ��ͼƬ����ӵ� ����input�� �ͱ�����һͬ�ύ
    		$("#imgName").attr("value",resp.fileName);
        	 })��
    	 //�ļ��ϴ�����
    	 uploader.on("uploadError",function(file){
    		 $("#"+file.id).find("span").text("�ϴ�ʧ��");
    	 });
    	 //�����ťʱ����ʼ�ϴ�
    	 $("#btn").click(function(){
    		 uploader.upload();
    	 });
     });