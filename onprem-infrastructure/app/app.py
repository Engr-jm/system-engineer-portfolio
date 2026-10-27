import os
import pymysql

from flask import Flask, jsonify, redirect, render_template_string, request

app = Flask(__name__)

def connect_db():
    return pymysql.connect(
        host=os.environ["DB_HOST"],
        port=int(os.environ["DB_PORT"]),
        user=os.environ["DB_USER"],
        password=os.environ["DB_PASSWORD"],
        database=os.environ["DB_NAME"],
        charset="utf8mb4",
        cursorclass=pymysql.cursors.DictCursor,
        connect_timeout=5,
    )

@app.get("/health")
def health():
    return jsonify(service="APP01", status="ok")

@app.get("/ready")
def ready():
    try:
        with connect_db() as conn:
            with conn.cursor() as cursor:
                cursor.execute("SELECT 1")
        return jsonify(app="ok", database="ok")
    except pymysql.MySQLError:
        return jsonify(app="ok", database="unavailable"), 503

@app.route("/", methods=["GET", "POST"])
def home():
    if request.method == "POST":
        content = request.form.get("content", "").strip()

        if not content or len(content) > 255:
            return "내용은 1~255자로 입력하세요.", 400

        with connect_db() as conn:
            with conn.cursor() as cursor:
                cursor.execute(
                    "INSERT INTO messages (content) VALUES (%s)",
                    (content,)
                )
            conn.commit()

        return redirect("./", code=303)

    with connect_db() as conn:
        with conn.cursor() as cursor:
            cursor.execute(
                "SELECT id, content, created_at "
                "FROM messages ORDER BY id DESC LIMIT 20"
            )
            messages = cursor.fetchall()

    return render_template_string("""
    <!DOCTYPE html>
    <html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, initial-scale=1">
        <title>On-Premise Infrastructure</title>
    </head>
    <body>
        <h1>On-Premise Infrastructure</h1>
        <p>WEB01 Nginx → APP01 Docker → DB01 MariaDB</p>

        <h2>방명록 작성</h2>
        <form method="POST">
            <input name="content" maxlength="255"
                   placeholder="메시지를 입력하세요" required>
            <button type="submit">저장</button>
        </form>

        <h2>저장된 메시지</h2>
        {% for msg in messages %}
            <p>
                #{{ msg.id }} |
                {{ msg.content }} |
                {{ msg.created_at }}
            </p>
        {% else %}
            <p>아직 등록된 메시지가 없습니다.</p>
        {% endfor %}
    </body>
    </html>
    """, messages=messages)
