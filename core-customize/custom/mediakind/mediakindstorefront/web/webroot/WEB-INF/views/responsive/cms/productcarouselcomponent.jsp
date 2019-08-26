<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product" %>
<%@ taglib prefix="component" tagdir="/WEB-INF/tags/shared/component" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<spring:htmlEscape defaultHtmlEscape="true" />
<c:url value="/cart/add" var="addToCartUrl"/>

<c:choose>
       <c:when test="${not empty productData}">
              <div class="carousel__component">
                     <div class="carousel__component--headline">${fn:escapeXml(title)}</div>

                     <c:choose>
                           <c:when test="${component.popup}">
                                  <div class="carousel__component--carousel js-owl-carousel js-owl-lazy-reference js-owl-carousel-reference">
                                         <div id="quickViewTitle" class="quickView-header display-none">
                                                <div class="headline">
                                                       <span class="headline-text"><spring:theme code="popup.quick.view.select"/></span>
                                                </div>
                                         </div>
                                         <c:forEach items="${productData}" var="product">

                                                <c:url value="${product.url}/quickView" var="productQuickViewUrl"/>
                                                <div class="carousel__item">
                                                       <a href="${productQuickViewUrl}" class="js-reference-item">
                                                              <div class="carousel__item--thumb">
                                                                     <product:productPrimaryReferenceImage product="${product}" format="product"/>
                                                              </div>
                                                              <div class="carousel__item--name">${fn:escapeXml(product.name)}</div>
                                                              <div class="carousel__item--price"><format:fromPrice priceData="${product.price}"/></div>
                                                       </a>
                                                </div>
                                         </c:forEach>
                                  </div>
                           </c:when>
                           <c:otherwise>
                                  <div class="carousel__component--carousel js-owl-carousel js-owl-default">
                                         <c:forEach items="${productData}" var="product">

                                                <c:url value="${product.url}" var="productUrl"/>

                                                <div class="carousel__item">
                                                       <a href="${productUrl}">
                                                              <div class="carousel__item--thumb">
                                                                     <product:productPrimaryImage product="${product}" format="product"/>
                                                              </div>
                                                              <div class="carousel__item--name">${fn:escapeXml(product.name)}</div>
                                                              <div class="carousel__item--price"><format:fromPrice priceData="${product.price}"/></div>
                                                       </a>
                                                              <form:form method="post" id="addToCartForm"
                                                                     class="add_to_cart_form" action="${addToCartUrl}">
                                                                     <c:if test="${product.purchasable}">
                                                                           <input type="hidden" maxlength="3" size="1" id="qty"
                                                                                  name="qty" class="qty js-qty-selector-input" value="1">
                                                                     </c:if>
                                                                     <input type="hidden" name="productCodePost"
                                                                            value="${fn:escapeXml(product.code)}" />

                                                                     <c:if test="${empty showAddToCart ? true : showAddToCart}">
                                                                           <c:set var="buttonType">button</c:set>
                                                                           <c:if
                                                                                  test="${product.purchasable and product.stock.stockLevelStatus.code ne 'outOfStock' }">
                                                                                  <c:set var="buttonType">submit</c:set>
                                                                           </c:if>
                                                                           <c:choose>
                                                                                  <c:when test="${fn:contains(buttonType, 'button')}">
                                                                                         <button type="${buttonType}"
                                                                                                class="btn btn-primary btn-block js-add-to-cart btn-icon glyphicon-shopping-cart outOfStock"
                                                                                                disabled="disabled">
                                                                                                <spring:theme code="product.variants.out.of.stock" />
                                                                                         </button>
                                                                                  </c:when>
                                                                                  <c:otherwise>
                                                                                         <ycommerce:testId code="addToCartButton">
                                                                                                <button id="addToCartButton" type="${buttonType}"
                                                                                                       class="btn btn-primary btn-block js-add-to-cart js-enable-btn btn-icon glyphicon-shopping-cart"
                                                                                                       disabled="disabled">
                                                                                                       <spring:theme code="basket.add.to.basket" />
                                                                                                </button>
                                                                                         </ycommerce:testId>
                                                                                  </c:otherwise>
                                                                           </c:choose>
                                                                     </c:if>
                                                              </form:form>
                                                       <div id="addToCartTitle" class="display-none">
                                                              <div class="add-to-cart-header">
                                                                     <div class="headline">
                                                                           <span class="headline-text"><spring:theme
                                                                                         code="basket.added.to.basket" /></span>
                                                                     </div>
                                                              </div>
                                                       </div>
                                                </div>
                                         </c:forEach>
                                  </div>
                           </c:otherwise>
                     </c:choose>
              </div>
       </c:when>

       <c:otherwise>
              <component:emptyComponent/>
       </c:otherwise>
</c:choose>