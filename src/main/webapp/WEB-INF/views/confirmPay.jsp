<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>

<%@include file="include/header.jsp"%>
<%@include file="include/top.jsp"%>
<div class="search_bar clearfix">
    <a href="home" class="logo fl"><img src="../home/images/logo.png"></a>
    <div class="sub_page_name fl">|&nbsp;&nbsp;&nbsp;&nbsp;确认收货</div>
    <div class="search_con fr">
        <form action="/searchProduct">
            <input type="text" value="${param.keyword}" class="input_text fl" placeholder="搜索商品" name="keyword">
            <button type="submit" class="input_btn fr">搜索</button>
        </form>
    </div>
</div>
<div class="confirmPayPageDiv">
    <div class="confirmPayOrderInfoDiv">
        <div class="confirmPayOrderInfoText">我已收到货，同意支付宝付款</div>
    </div>
    <div class="confirmPayOrderItemDiv">
        <div class="confirmPayOrderItemText">订单信息</div>
        <table class="confirmPayOrderItemTable">
            <thead>
                <th colspan="2">宝贝</th>
                <th width="120px">单价</th>
                <th width="120px">数量</th>
                <th width="120px">商品总价</th>
                <th width="120px">运费</th>
            </thead>
            <c:forEach items="${order.orderItems}" var="oi">
                <tr>
                    <td><img width="50px" src="img/product/${oi.product.id}/1.jpg"></td>
                    <td class="confirmPayOrderItemProductLink">
                        <a href="#nowhere">${oi.product.name}</a>
                    </td>
                    <td>￥${oi.product.price}</td>
                    <td>${oi.number}</td>
                    <td><span class="conformPayProductPrice">￥<fmt:formatNumber type="number" value="${oi.product.price * oi.number}" minFractionDigits="2"/></span></td>
                    <td><span>快递 ： 0.00 </span></td>
                </tr>
            </c:forEach>
        </table>

        <div class="confirmPayOrderItemText" style="float: right;">
            实付款： <span class="confirmPayOrderItemSumPrice">￥${order.total}</span>
        </div>

    </div>
    <div class="confirmPayOrderDetailDiv">

        <table class="confirmPayOrderDetailTable">
            <tr>
                <td>订单编号：</td>
                <td>${order.order_code}</td>
            </tr>
            <tr>
                <td>卖家昵称：</td>
                <td>一颗欢快的蘑菇</td>
            </tr>
            <tr>
                <td>收货信息：</td>
                <td>${order.address}，${order.receiver}， ${order.phone}</td>
            </tr>
            <tr>
                <td>成交时间：</td>
                <td>${order.create_date}</td>
            </tr>
        </table>
    </div>
    <div class="confirmPayButtonDiv">
        <div class="confirmPayWarning">请您收到货后，再确认收货！</div>
        <a href="orderConfirmed?order_id=${order.id}">
            <button class="confirmPayButton">确认支付</button>
        </a>
    </div>
</div>
<%@include file="include/footer.jsp"%>