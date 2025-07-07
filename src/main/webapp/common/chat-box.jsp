<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chatbox FAQ</title>
        <style>
            :root {
                --primary: #007bff;
                --primary-light: #e0f2ff;
                --accent: #f1f1f1;
            }

            body {
                margin: 0;
                font-family: "Segoe UI", sans-serif;
                background: transparent;
            }

            #chat-container {
                width: 100%;
                height: 100%;
                box-sizing: border-box;
                border-radius: 12px;
                border: 1px solid #ccc;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                display: flex;
                flex-direction: column;
                overflow: hidden;
            }

            #chat-header {
                background: var(--primary);
                color: white;
                padding: 12px 16px;
                font-weight: bold;
            }

            #chat-body {
                padding: 12px 16px;
                display: flex;
                flex-direction: column;
                gap: 10px;
                overflow-y: auto;
                background: white;
                height: 100%;
            }

            .message {
                padding: 10px 14px;
                border-radius: 15px;
                max-width: 85%;
                display: inline-block;
                font-size: 14px;
                line-height: 1.4;
            }
            .message.bot {
                background: var(--primary-light);
                align-self: flex-start;
            }
            .message.user {
                background: var(--accent);
                align-self: flex-end;
            }

            .option-button {
                background: white;
                border: 1px solid #ccc;
                padding: 8px 12px;
                border-radius: 8px;
                cursor: pointer;
                font-size: 14px;
                width: fit-content;
            }

            .option-button:hover {
                background: #e2e8f0;
            }
        </style>
    </head>
    <body>
        <div id="chat-container">
            <div id="chat-header">Trung tâm trợ giúp</div>
            <div id="chat-body">
                <div class="message bot">Chào bạn! Mình có thể giúp gì hôm nay? Hãy chọn chủ đề bên dưới 👇</div>
                <div id="topic-buttons"></div>
            </div>
        </div>

        <script>
            const chatBody = document.getElementById("chat-body");
            const topicButtons = document.getElementById("topic-buttons");

            let faqData = {}; // Biến toàn cục để lưu dữ liệu

            fetch("<%= request.getContextPath() %>/faq")
                    .then(res => res.json())
                    .then(data => {
                        faqData = data;
                        Object.keys(data).forEach(topic => {
                            const btn = document.createElement("button");
                            btn.className = "option-button";
                            btn.textContent = topic;
                            btn.onclick = () => showTopic(topic);
                            topicButtons.appendChild(btn);
                        });
                    })
                    .catch(err => {
                        appendBot("Không thể tải dữ liệu từ máy chủ.");
                        console.error("FAQ fetch error:", err);
                    });

            function showTopic(topic) {
                topicButtons.remove(); // Xoá vùng nút chủ đề

                appendBot(`Bạn đã chọn chủ đề <b>${topic}</b>. Vui lòng chọn câu hỏi bạn quan tâm:`);

                const questionContainer = document.createElement("div");
                questionContainer.id = "question-buttons";
                chatBody.appendChild(questionContainer);

                faqData[topic].forEach((item) => {
                    const btn = document.createElement("button");
                    btn.className = "option-button";
                    btn.textContent = item.q;
                    btn.onclick = () => {
                        appendUser(item.q);
                        appendBot(item.a);
                        btn.disabled = true; // Không cho click lại
                    };
                    questionContainer.appendChild(btn);
                });

                chatBody.scrollTop = chatBody.scrollHeight;
            }

            function appendBot(text) {
                const div = document.createElement("div");
                div.className = "message bot";
                div.innerHTML = text;
                chatBody.appendChild(div);
                chatBody.scrollTop = chatBody.scrollHeight;
            }

            function appendUser(text) {
                const div = document.createElement("div");
                div.className = "message user";
                div.innerText = text;
                chatBody.appendChild(div);
                chatBody.scrollTop = chatBody.scrollHeight;
            }
        </script>

    </body>
</html>
