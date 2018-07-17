����javax.servlet-api 3.1���ļ��ϴ�
maven������jar

@WebServlet( "/javaUpload" )
@MultipartConfig
public class javaUpload extends BaseServlet {
 private static final long serialVersionUID = 1L;
 protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
 forward("webuploader", req, resp);
 }
 protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
 
 Part part = req.getPart("file");
 //����ļ� �� ��С ����
 String header = part.getHeader("Content-Disposition");
 
 // ƴ���ϴ����ļ��� ����Ψһ���ļ���
 header = header.split(";")[2].split("\"")[1];
 
 String fileName = UUID.randomUUID().toString()+header.substring(header.lastIndexOf("."));
 //��part����ļ���������
 InputStream in = part.getInputStream();
 //�½�����������ļ����µ��ļ���
 OutputStream out = new FileOutputStream(new File(new File("D:/upload3"), fileName));
 //��part��������copy��ָ���ļ���
 IOUtils.copy(in, out);
 Map<String ,Object> map = new HashMap();
 //Ŀǰֻ���� �ϴ��ɹ����json ��Ӧ���� 
 map.put("success", true);//���ı����ļ��ϴ�ͼƬ�ɹ���json�źţ�������˸��ı����ִ��źŻ��Զ���file_path ��Ӧ��Ϣչʾ��ͼƬsrc��
 map.put("file_path", Config.getProperty("http.address")+ fileName);//�ϴ��ɹ�����ǰ�˴��ʹ�ͼƬ��������Դ·����
 map.put("fileName", fileName);//��ǰ�˴��͸��ݴ�ͼƬ���ɵ�ͼƬ��
 send(resp, map);//��json������Ӧǰ��
 }
}???

  Apache  ?commons-fileupload
����commons-fileupload ��1.3.1

@WebServlet("/upload")
public class Upload extends BaseServlet {
	private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward("text/upload", req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		// 1.�����ļ��ϴ�·��
		File upFile = new File("D:/upload");
		if (!upFile.exists()) {
			upFile.mkdir();
		}
		// 2��������ʱ·��
		File tempFile = new File("D:/temp");
		if (!tempFile.exists()) {
			tempFile.mkdir();
		}
		// 3.�жϱ����� enctype �Ƿ�Ϊmultipart/form-data
		if (ServletFileUpload.isMultipartContent(req)) {

			DiskFileItemFactory factory = new DiskFileItemFactory();

			factory.setSizeThreshold(1024);

			factory.setRepository(tempFile);
			// ����factory ����servlet�ļ��ϴ�����
			ServletFileUpload upload = new ServletFileUpload(factory);
			// �ö�����form�� ���ݵļ���

			try {
				List<FileItem> itemList = upload.parseRequest(req);
				for (FileItem item : itemList) {
					if (item.isFormField()) {
						// ��ͬ���ݻ�ô����ݵ���Ϣ
						String fileName = item.getFieldName();
						String value = item.getString("UTF-8");
					} else {
						// Ϊ�ļ�����ʱ
						String fileName = item.getFieldName();
						String name = item.getName();
						// ����Ψһ���ļ���
						name = UUID.randomUUID().toString() + name.substring(name.lastIndexOf("."));
						InputStream in = item.getInputStream();
						FileOutputStream out = new FileOutputStream(new File(upFile, name));
						IOUtils.copy(in, out);
						out.flush();
						out.close();
						in.close();
						System.out.println("�ļ��ϴ��ɹ���");

					}
				}

			} catch (FileUploadException e) {
				e.printStackTrace();
			}
		} else {
			throw new ServletException("���쳣");
		}
	}
}

�ļ���Ԥ��������

@WebServlet("/download")
public class Download extends BaseServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// ���ص��ļ�������get ������
		String fileName = req.getParameter("fileName");//��������в���UUID �ļ���
		String name = req.getParameter("name");//����ļ�������
		//���ص���Դ·���ļ�
		File file = new File(new File("D:/img/upload"), fileName);
		if (file.exists()) {
			//���ص����� ǰ�˸�����Ӧͷ�������غ�Ԥ��
			if (StringUtils.isNotEmpty(name)) {
				// �����ļ�����
				resp.setContentType("application/octet-stream");
				// ��֪�ļ���С
				resp.setContentLength((int) file.length());
				// �����Ӧͷ ����ǰ��
				resp.addHeader("Content-Disposition", "attachment; filename=\"" + name + "\"");
			}
			//��file�л��������  �������Ӧ��
			InputStream in = new FileInputStream(file);
			OutputStream out = resp.getOutputStream();
            //
			IOUtils.copy(in, out);
			out.flush();
			out.close();
			in.close();
		} else {
			resp.sendError(404, "��Դδ�ҵ�");
		}
	}
}
