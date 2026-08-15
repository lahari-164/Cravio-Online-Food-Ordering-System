<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Read theme preference cookie set by theme.js / servlet
    String cravioTheme = "light";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie ck : cookies) {
            if ("cravioTheme".equals(ck.getName())) {
                cravioTheme = ck.getValue();
                break;
            }
        }
    }
    String pageTitle = (String) request.getAttribute("pageTitle");
    if (pageTitle == null || pageTitle.trim().isEmpty()) {
        pageTitle = "Cravio | Premium Food Delivery";
    } else {
        pageTitle = pageTitle + " | Cravio";
    }
%>
<!DOCTYPE html>
<html lang="en" data-theme="<%= cravioTheme %>">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Cravio - Premium Online Food Ordering Platform. Order gourmet meals, track live delivery, and experience culinary luxury.">
    <meta name="author" content="Cravio">

    <title><%= pageTitle %></title>

    <%-- Google Fonts: Plus Jakarta Sans + Outfit --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <%-- Font Awesome 6 Icons --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <%-- Cravio CSS Architecture --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/design-tokens.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animations.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages.css">

    <script src="${pageContext.request.contextPath}/js/theme.js"></script>
</head>
<body>
    <%-- Toast Container --%>
    <div class="cravio-toast-container" id="cravioToastContainer"></div>
