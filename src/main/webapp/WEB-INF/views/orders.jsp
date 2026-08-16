<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "My Orders");
    request.setAttribute("activePage", "orders");
%>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<section class="container" style="padding: 2.5rem 0 4rem 0;">
  <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; gap: 1rem; flex-wrap: wrap;">
    <div>
      <span class="badge badge-offer" style="margin-bottom: 0.5rem;">MY ORDERS</span>
      <h1 style="font-size: 2.25rem; margin: 0;">Order History</h1>
    </div>
    <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-secondary"><i class="fa-solid fa-bag-shopping"></i> Order Again</a>
  </div>

  <div id="ordersPageStatus" style="margin-bottom: 1.25rem; color: var(--text-muted); font-size: 0.95rem;"></div>
  <div id="ordersList" style="display: grid; gap: 1.5rem;"></div>
</section>

<%@ include file="footer.jsp" %>

<script>
  var orderCtx = '<%= request.getContextPath() %>';

  function money(val) {
    var n = Number(val || 0);
    return '₹' + n.toFixed(0);
  }

  function statusPill(status) {
    var label = status || 'Pending';
    var palette = {
      Pending: 'var(--primary-light)',
      Preparing: '#fff3d6',
      'Out for Delivery': '#dff7ef',
      Delivered: '#dff7ef',
      Cancelled: '#fbe1e1'
    };
    var color = {
      Pending: 'var(--primary)',
      Preparing: '#b7791f',
      'Out for Delivery': '#0c8f63',
      Delivered: '#0c8f63',
      Cancelled: '#c0392b'
    };

    return '<span style="display: inline-block; padding: 0.35rem 0.7rem; border-radius: 999px; background: ' + (palette[label] || 'var(--bg-subtle)') + '; color: ' + (color[label] || 'var(--text-main)') + '; font-size: 0.72rem; font-weight: 700; text-transform: uppercase;">' + label + '</span>';
  }

  function renderOrders(orders) {
    var listEl = document.getElementById('ordersList');
    var statusEl = document.getElementById('ordersPageStatus');

    if (!orders || !orders.length) {
      if (statusEl) statusEl.textContent = 'You have not placed any orders yet.';
      if (listEl) {
        listEl.innerHTML = '<div class="card-glass" style="padding: 2rem; text-align: center; color: var(--text-muted);">' +
          '<i class="fa-solid fa-bag-shopping" style="font-size: 2rem; margin-bottom: 0.75rem; display: inline-block; color: var(--primary);"></i>' +
          '<h3 style="font-size: 1.15rem; margin-bottom: 0.25rem; color: var(--text-main);">No orders found</h3>' +
          '<p>Start ordering from your favorite restaurants to see your order history here.</p>' +
          '</div>';
      }
      return;
    }

    if (statusEl) {
      statusEl.textContent = 'Showing ' + orders.length + ' order' + (orders.length > 1 ? 's' : '') + ' for your account.';
    }

    listEl.innerHTML = orders.map(function (order) {
      var orderItems = order.items || [];
      var itemText = orderItems.length
        ? orderItems.map(function (item) {
            var itemName = item && item.product && item.product.name ? item.product.name : 'Food item';
            return '<div style="display: flex; justify-content: space-between; gap: 1rem; margin-bottom: 0.35rem;">' +
              '<span>' + itemName + ' x ' + (item.quantity || 1) + '</span>' +
              '<strong>' + money((item.price || 0) * (item.quantity || 1)) + '</strong>' +
              '</div>';
          }).join('')
        : '<div style="color: var(--text-muted);">No item details available.</div>';

      var placedText = order.orderDate ? new Date(order.orderDate).toLocaleString() : 'Recently';
      var restaurantName = order.restaurantName || 'Cravio Order';
      var cardHtml =
        '<div class="card-glass" style="padding: 1.5rem; border-radius: var(--radius-lg);">' +
          '<div style="display: flex; justify-content: space-between; align-items: center; gap: 1rem; flex-wrap: wrap; margin-bottom: 1rem;">' +
            '<div>' +
              '<div style="font-size: 0.8rem; color: var(--text-muted); margin-bottom: 0.25rem;">Order #CRV-' + order.id + '</div>' +
              '<h3 style="margin: 0; font-size: 1.35rem;">' + restaurantName + '</h3>' +
            '</div>' +
            '<div style="display: flex; align-items: center; gap: 0.75rem; flex-wrap: wrap; justify-content: flex-end;">' +
              statusPill(order.status) +
              '<strong style="font-size: 1.2rem; color: var(--primary);">' + money(order.totalAmount || 0) + '</strong>' +
            '</div>' +
          '</div>' +
          '<div style="display: grid; grid-template-columns: 1.5fr 1fr; gap: 1.5rem;">' +
            '<div>' +
              '<div style="font-size: 0.8rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.08em; margin-bottom: 0.5rem;">Items</div>' +
              '<div style="padding: 0.9rem 1rem; background: var(--bg-subtle); border: 1px solid var(--border-color); border-radius: var(--radius-md);">' +
                itemText +
              '</div>' +
            '</div>' +
            '<div>' +
              '<div style="font-size: 0.8rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.08em; margin-bottom: 0.5rem;">Details</div>' +
              '<div style="padding: 0.9rem 1rem; background: var(--bg-subtle); border: 1px solid var(--border-color); border-radius: var(--radius-md); line-height: 1.8; font-size: 0.9rem; color: var(--text-main);">' +
                '<div><strong>Placed:</strong> ' + placedText + '</div>' +
                '<div><strong>Payment:</strong> ' + (order.paymentMethod || 'Card') + '</div>' +
                '<div><strong>Address:</strong> ' + (order.deliveryAddress || 'Delivery address not available') + '</div>' +
              '</div>' +
            '</div>' +
          '</div>' +
        '</div>';

      return cardHtml;
    }).join('');
  }

  async function loadOrders() {
    var statusEl = document.getElementById('ordersPageStatus');

    if (!window.CravioAuth || !window.CravioAuth.isLoggedIn()) {
      if (statusEl) statusEl.textContent = 'Please log in to view your order history.';
      return;
    }

    try {
      var res = await fetch(orderCtx + '/api/orders/my-orders', {
        method: 'GET',
        headers: { 'Content-Type': 'application/json' }
      });

      if (!res.ok) {
        throw new Error('Unable to load orders');
      }

      var orders = await res.json();
      var enrichedOrders = await Promise.all((orders || []).map(async function (order) {
        try {
          var detailRes = await fetch(orderCtx + '/api/orders/' + order.id);
          if (!detailRes.ok) return Object.assign({}, order, { items: [] });
          var detail = await detailRes.json();
          return Object.assign({}, order, { items: detail.items || [] });
        } catch (err) {
          return Object.assign({}, order, { items: [] });
        }
      }));

      renderOrders(enrichedOrders);
    } catch (error) {
      if (statusEl) statusEl.textContent = 'Unable to load your orders right now. Please try again later.';
      var listEl = document.getElementById('ordersList');
      if (listEl) listEl.innerHTML = '';
    }
  }

  document.addEventListener('DOMContentLoaded', function () {
    loadOrders();
  });
</script>
