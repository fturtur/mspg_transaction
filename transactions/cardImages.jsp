<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="com.sm.pcs.admin.vo.PcsSkusVO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Set"%>

<% 
//System.out.println("--card image---");
try{	
	List<PcsSkusVO> skusVOs = (List<PcsSkusVO>)session.getAttribute("skus");

		
  Integer id =Integer.parseInt(request.getParameter("id"));
  String logo = request.getParameter("logo");
  String policyImg = request.getParameter("policyImg");

	//Integer id = (Integer)Integer.parseInt(id_s); 
 for(PcsSkusVO sku:skusVOs){		
		
	if(sku.getId().intValue()==id.intValue()){
	byte[] imageData =new byte[1024];
	
	if(policyImg!=null && !"".equals(policyImg)){		
		imageData = (byte[])session.getAttribute("policyImg");
		
	}else if(logo!=null && !"".equals(logo)){
		
		imageData = (byte[])sku.getSkuConfigurationVO().getSkuLogo();
	
	}else{
		imageData = (byte[])sku.getSkuConfigurationVO().getSkuIcon();
	}

	//int len = imageData.length;
	if(imageData!=null){
		int len1 = imageData.length;		
		response.setContentType("image/jpeg");	    
	    response.setHeader("Content-disposition","attachment; filename=" +"test");
	    response.getOutputStream().write(imageData,0,len1); 		    
	    response.getOutputStream().flush();        
	    response.getOutputStream().close();
	 }
   }
}
	
}catch(Exception e) {
	e.printStackTrace();
	System.out.println("--error--"+e.getMessage());
}
%>
