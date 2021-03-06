<#escape x as (x!)?html>
 							
		<#macro showModelRows rows>	 
			<#if (rows?size > 0) >
				<table class="table table-condensed table-bordered model-rows-table">																								
					<tr>
						<th>Property</th>
						<th>Type</th>
						<th>Description</th>
						<th>Format</th>
						<th>Required</th>
						<th>ReadOnly</th>
					</tr>
					<#list rows as row>
						<tr>
							<td>${row.getOgnlPath()}</td>
							<td>${row.getTypeStr()}</td>
							<td>${row.getProperty().getDescription()}</td>
							<td>${row.getProperty().getFormat()}</td>
							<td>${row.getProperty().getRequired()?string('Y', 'N')}</td>
							<td>
								<#if row.getProperty().getReadOnly()??>
									${row.getProperty().getReadOnly()?string('Y', 'N')}
								</#if>
							</td>
						</tr>										
					</#list>
				</table>									
			</#if>
		</#macro>  		


	<!DOCTYPE html>
	<html lang="en">
		<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		
		<#noescape>
			${css}
		</#noescape>
		
			
		<title>
			${sw.getTitle()}
		</title>
	
		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
			<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
		</head>
		<body>
		
		<div class="container">
			<h1>${sw.getTitle()}</h1>		
			
			
				<h2>Information</h2>		
				<div>						
					<table class="table table-bordered info-table">
						<tbody>
						<#if sw.getBaseUrls()??>
								<tr>											
									<td>Base URL</td> 
									<td>
										<#list sw.getBaseUrls() as baseUrl>
											<p>${baseUrl}</p>
										</#list>										
									</td>
								</tr>							
						</#if>
						
						
						<#if sw.swagger.getInfo()??>
								<tr>											
									<td>Version</td> <td>${sw.swagger.getInfo().getVersion()}</td>
								</tr>
								
								
								
								<#if sw.swagger.getInfo().getDescription()??>
									<tr>											
										<td>Description</td> <td> <#noescape> ${sw.getDescription()!}  </#noescape> </td>
									</tr>
								</#if>
								
								<#if sw.swagger.getInfo().getContact()??>
									<#if sw.swagger.getInfo().getContact().getName()??>
										<tr>											
											<td>Contact Name</td><td>${sw.swagger.getInfo().getContact().getName()}</td>																																						 				
										</tr>
									</#if>
									
									<#if sw.swagger.getInfo().getContact().getEmail()??>
										<tr>											
											<td>Contact Email</td><td>${sw.swagger.getInfo().getContact().getEmail()}</td>																																						 				
										</tr>
									</#if>
									<#if sw.swagger.getInfo().getContact().getUrl()??>
										<tr>											
											<td>Contact URL</td><td>${sw.swagger.getInfo().getContact().getUrl()}</td>																																						 				
										</tr>
									</#if>			
								</#if>	
								<#if sw.swagger.getInfo().getLicense()??>														
									<tr>											
										<td>License</td> <td>${sw.swagger.getInfo().getLicense().getName()}</td>																																						 				
									</tr>	
								</#if>
								<#if sw.swagger.getInfo().getTermsOfService()??>
									<tr>											
										<td>Terms Of Service</td> <td>${sw.swagger.getInfo().getTermsOfService()}</td>																																						 				
									</tr>	
								</#if>
						</#if>																																										
						</tbody>
					</table>	
				</div>						

 
			
			<h2>Table of Contents</h2>		
			<#if sw.getTags()??>
			<#list sw.getTags() as tag>
			
				<h3>${tag.getName()}</h3>
				<h4>${tag.getDescription()}</h4>
				
				<div>						
					<table class="table table-bordered table-condensed summary-table">
						<tbody>
								<tr>
									<th>Index</th>
									<th>Method</th>								
									<th>Path</th>		
									<th>Summary</th>																												
								</tr>						
															 												
								<#list sw.getOperationIdsOfTag(tag.getName()) as operationId>
									<tr>
										<td><a href="#${operationId.serialize()}">${operationId_index + 1}</a></td>								
										<td><a href="#${operationId.serialize()}">${operationId.getMethod()}</a></td>								
										<td><a href="#${operationId.serialize()}">${operationId.getPath()}</a></td>
										<td>
											<#if sw.getOperation(operationId)??>
												${sw.getOperation(operationId).getSummary()}
											</#if>											
										</td>											 					
									</tr>								
								</#list>										
						</tbody>
					</table>	
				</div>	
				
			</#list>
			</#if>
			
	
			
			
			
			<!-- One tag after another-->			
			
			<#if sw.getTags()??>
			<#list sw.getTags() as tag>					
				<h2>${tag.getName()}</h2>
					<#list sw.getOperationIdsOfTag(tag.getName()) as operationId>
					
						<!-- every operation -->
						<h3><a name="${operationId.serialize()}">${operationId.getMethod()} ${operationId.getPath()}</a></h3>
						
						<div>						
							<table class="table table-bordered table-condensed operation-intro-table">
								<tbody>
										
										<tr>
											<td>Summary</td> <td>${sw.getOperation(operationId).getSummary()}</td>
										</tr>
										<tr>											
											<td>Notes</td> <td>${sw.getOperation(operationId).getDescription()}</td>
										</tr>
										<tr>											
											<td>Consumes</td> <td>${displayList(sw.getOperation(operationId).getConsumes())}</td>
										</tr>
										<tr>											
											<td>Produces</td> <td>${displayList(sw.getOperation(operationId).getProduces())}</td>																																						 				
										</tr>								
												
			
									
								</tbody>
							</table>	
						</div>	
									
					<h4>Parameters</h4>	
								
					<#if (sw.getOperation(operationId).getParameters()??  && (sw.getOperation(operationId).getParameters()?size > 0)) >
			 																					
						<div>				
							<table class="table table-bordered param-table">
								<tbody>
										<tr>
											<th>Name</th>										
											<th>Parameter Type</th>	
											<th>Data Type</th>																					
											<th>Required</th>		
											<th>Description</th>																														
										</tr>	
								<#list sw.getOperation(operationId).getParameters() as param>
											<tr>																	
												<td>${param.getName()}</td>
												<td>${param.getIn()}</td>
												<td>
													<div class="panel panel-default">														
														<div class="panel-heading">${paramTypeStr(param, operationId)}</div>														
														<@showModelRows rows=paramToModelRows(param, operationId)/>																																								
													</div>
												</td>											
												<td>${param.getRequired()?string('Y', 'N')}</td>
												<td>${param.getDescription()}</td>
											</tr>								 					

									</tr>
								</#list>												
																				
								</tbody>						
													
							</table>		
						</div>	
										
					<#else>
						No Parameters
					</#if>						
						

						<h4>Responses</h4>		
						<div>				
							<table class="table table-bordered response-table">
								<tbody>
										<tr>
											<th>HTTP Status Code</th>										
											<th>Reason</th>	
											<th>Response Type</th>																																																													
										</tr>	
										<#if sw.getOperation(operationId).getResponses()??>
			 							<#list sw.getOperation(operationId).getResponses()?keys as httpCode>
			 								
											<tr>																	
												<td>${httpCode}</td>
												<td>${sw.getOperation(operationId).getResponses()[httpCode] .getDescription()}</td>
												<td>
													<#if sw.getOperation(operationId).getResponses()[httpCode].getSchema()??>													
															<div class="panel panel-default">														
																<div class="panel-heading">${propertyTypeStr(sw.getOperation(operationId).getResponses()[httpCode].getSchema(), opeartionId)}</div>																
																<@showModelRows rows=propertyToModelRows(sw.getOperation(operationId).getResponses()[httpCode].getSchema(), opeartionId)/>																																								
															</div>														 
													</#if>																								
												</td>											
											</tr>								 					
										</#list>
										</#if>
									</tr>										
																				
								</tbody>						
													
							</table>	
						</div>
		


															
					</#list>			
					
					
											
			</#list>
			</#if> 	
		</div>			
		</body>
	</html>

 
</#escape>


