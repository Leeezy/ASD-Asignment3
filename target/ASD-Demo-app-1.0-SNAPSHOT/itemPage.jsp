<%-- 
    Document   : itemPage
    Created on : 16/08/2019, 5:48:55 PM
    Author     : Calvin
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="asd.demo.model.dao.MongoDBConnector"%>
<%@page import="asd.demo.model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Item Page</title>
        <link rel="stylesheet" href="css/ASDStyle.css">
    </head>
    <body>  
        <jsp:include page="header.jsp"/>    
        <div>
            <%
                //Attributes recieved from itemServlet
                Item item = (Item) request.getAttribute("item");
                String error = (String) request.getAttribute("err");

                request.setAttribute("buy_product_item", item);
                
                //String id = request.getParameter("id");
                MongoDBConnector connector = new MongoDBConnector();
                if (item != null) {
            %>
            <div class="mainBox">
                <!-- Display errors -->
                <% if (error.length() > 0) {%>
                <%=error%>
                <%} else {%>

                <!-- Item info-->
                <div class="col">
                    <h><%=item.getName()%></h>
                    <p></p> 
                    <img src="<%=item.getImage()%>" style="width:500px; height:400px;"/>
                    <div> Description </div>
                    <div> <%=item.getDescription()%> </div>
                    <hr>
                    <div> Category: <%=item.getCategory()%> </div>
                    <div> Price: $<%=item.getPrice()%> </div>
                    <div> Expiration Date: <%=item.getExpDate()%></div>

                    <a href="buyProduct.jsp"> Buy Now! </a>                
                </div>    

                
                <%if (connector.check("11111111", item.getID())) {%>
                <form method="post" action="delete.jsp" >
                    <div>  <input type="hidden" name="id" value = "<%=item.getID()%>"</div>
                    <input type = submit value = "dislike">
                </form>
                <%} else {%>

                <form method="post" action="add.jsp" >
                    <div>  <input type="hidden" name="id" value = "<%=item.getID()%>"</div>
                    <input type = submit value = "Like">
                    </div>
                </form>               
                <% }
                %>
                
                
                 <!--Shows the seller info of item-->
                <div class="col">
                    <div class="userBox">
                        <div><u> User Info </u></div>
                        <div> Listed User : <a href="./profile?id=<%=item.getSellerID()%>" ><%=connector.getusername(item.getSellerID())%></a></div>                 
                        <div> Listed Date: <%=item.getDateListed()%> </div>
                    </div>
                </div> 
                    
                <div class="reviewtitlebox">
                    <h2>Item Reviews</h2>
                    <a class="searchbutton" href="./review?id=<%=item.getID()%>">Leave a Review</a>
                </div>
                <%
                    //This retrieves all review data from the DB that contains the same ItemId as the item
                    ArrayList<Review> reviews = connector.getItemReviews(item.getID());
                    for (Review review : reviews) {
                        //Displays review Title, links to reviewer page and review Description
                %>
                <div class="reviewbox">
                    <h3><%=review.getTitle()%></h3>
                    <h5>by <a href="./profile?id=<%=review.getUserID()%>"><%=connector.getusername(review.getUserID())%></a></h5>
                    <h5><%=review.getDesc()%></h5>
                </div>
                <%  }
                        }
                    }
                %>  
            </div>        
        </div>
    </div>
    <% //connector.closeConnection();%>
</body>
</html>
