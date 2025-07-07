<%-- Ki?m tra tránh nhúng trùng --%>
<% if (request.getAttribute("faqChatIncluded") == null) {
     request.setAttribute("faqChatIncluded", true); %>

<!-- Chat Toggle Button -->
<style>
    #chat-toggle-btn {
        position: fixed;
        bottom: 20px;
        right: 20px;
        background: #007bff;
        color: white;
        border-radius: 50%;
        width: 56px;
        height: 56px;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 24px;
        z-index: 1000;
        cursor: pointer;
        box-shadow: 0 4px 10px rgba(0,0,0,0.2);
    }
    #chat-iframe {
        position: fixed;
        bottom: 90px;
        right: 20px;
        width: 360px;
        height: 480px;
        border: none;
        border-radius: 12px;
        z-index: 999;
        box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        display: none;
    }
</style>

<div id="chat-toggle-btn" onclick="toggleIframeChat()">?</div>

<iframe id="chat-iframe"
        src="<%= request.getContextPath() %>/common/chat-box.jsp">
</iframe>

<script>
    function toggleIframeChat() {
        const iframe = document.getElementById("chat-iframe");
        const btn = document.getElementById("chat-toggle-btn");
        const opened = iframe.style.display === "block";

        iframe.style.display = opened ? "none" : "block";
        btn.innerText = opened ? "?" : "?";
    }
</script>

<% } %>
