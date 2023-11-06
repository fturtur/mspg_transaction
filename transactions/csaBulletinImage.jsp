<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="com.sm.pcs.admin.vo.PcsCsaBulletinVO"%>



<% 
//System.out.println("--biller image---");
try{	
	PcsCsaBulletinVO bulletinVO = (PcsCsaBulletinVO)session.getAttribute("bulletinVO");
	if(bulletinVO!=null && bulletinVO.getBulletinImage()!=null){
		byte[] imageData =new byte[1024];
		imageData = (byte[])bulletinVO.getBulletinImage();
		if(imageData!=null){
			int len = imageData.length;		
			response.setContentType("image/jpeg");	    
		    response.setHeader("Content-disposition","attachment; filename=" +"test");
		    response.getOutputStream().write(imageData,0,len); 		    
		    response.getOutputStream().flush();        
		    response.getOutputStream().close();
		}
	}
}catch(Exception e) {
	e.printStackTrace();
	System.out.println("--error--"+e.getMessage());
}
%>