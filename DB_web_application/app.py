import psycopg2
from flask import Flask, render_template, request

connect = psycopg2.connect("dbname=db_term_project user=postgres password=a")
cur = connect.cursor()
app = Flask(__name__)

@app.route('/')
def main():
    return render_template("main.html")

@app.route('/modify_member',methods=['GET'])
def modify_member():
    cur.execute("SELECT * From member;")
    result = cur.fetchall()
    return render_template("modify_member.html", members=result)

@app.route('/modify_member2',methods=['POST'])
def modify_member2():
    mem_id = request.form["id"]
    name = request.form["name"]
    gender = request.form["gender"]
    regist_date = request.form["registration_date"]
    phone = request.form["phone_number"]
    send=request.form["send"]
    if send=='delete':
        query = "Delete From member where id=\'"+mem_id+"\';"
    elif send=='registration':
        query = "insert into member values(\'" + mem_id + "\',\'" + name + "\',\'" \
                + gender + "\', " + str(regist_date) + ", \'" + phone + "\');"
    else:
        query = "Update member set (id, name, gender, registration_date, phone_number) = (\'"\
                + mem_id + "\',\'" + name + "\',\'" \
                + gender + "\', " + str(regist_date) + ", \'" + phone + \
                "\') where id=\'"+mem_id+"\';"
    cur.execute(query)
    connect.commit()
    cur.execute("SELECT * From member;")
    result = cur.fetchall()
    return render_template("modify_member.html", members=result)

@app.route('/member_time',methods=['POST'])
def member_time():
    m_id=request.form['id']
    cur.execute("Select member_id, name, day_of_week, major_time "
                "from member, member_time "
                "where member_id=id and member_id=\'"+m_id+"\';")
    result = cur.fetchall()
    return render_template("major_time.html", major_time=result)

@app.route('/trainer',methods=['GET'])
def trainer():
    cur.execute("SELECT * From trainer;")
    result = cur.fetchall()
    return render_template("trainer.html", trainers=result)

@app.route('/trainer_time',methods=['POST'])
def trainer_time():
    t_id=request.form['id']
    cur.execute("Select trainer_id, name, day_of_week, major_time "
                "from trainer, trainer_time "
                "where trainer_id=id and trainer_id=\'"+t_id+"\';")
    result = cur.fetchall()
    return render_template("major_time.html", major_time=result)

@app.route('/print_pt',methods=['GET'])
def print_pt():
    cur.execute("SELECT member.id as m_id, member.name as m_name, member.phone_number as m_phone, "
                "trainer.id as t_id, trainer.name as t_name, trainer.phone_number as t_phone, "
                "PT.day_of_week, PT.pt_time "
                "From member, trainer, PT "
                "Where member.id=pt.member_id and trainer.id=pt.trainer_id;")
    result=cur.fetchall()
    return render_template("print_pt.html", pts=result)

@app.route('/search_member_pt',methods=['POST'])
def search_member_pt():
    m_id = request.form["id"]
    cur.execute("SELECT member.id as m_id, member.name as m_name, member.phone_number as m_phone, "
                "trainer.id as t_id, trainer.name as t_name, trainer.phone_number as t_phone, "
                "PT.day_of_week, PT.pt_time "
                "From member, trainer, PT "
                "Where member.id=pt.member_id and trainer.id=pt.trainer_id and "
                "member.id=\'"+m_id+"\';")
    result=cur.fetchall()
    return render_template("print_specific_pt.html", pts=result)

@app.route('/pt_recommendation',methods=['POST'])
def pt_recommendation():
    m_id = request.form["id"]
    cur.execute("create view recommendation_pt as "
                "select member_id, trainer_id, day_of_week, major_time "
                "from member_time natural join trainer_time "
                "where (trainer_id, day_of_week, major_time) not in "
                "(select trainer_id, day_of_week, pt_time from pt) and "
                "member_time.member_id = \'"+m_id+"\';")
    cur.execute("select member_id, member.name, trainer_id, trainer.name, day_of_week, major_time, "
                "member.phone_number, trainer.phone_number "
                "from recommendation_pt, member, trainer "
                "where recommendation_pt.member_id=member.id and recommendation_pt.trainer_id=trainer.id;")
    result=cur.fetchall()
    cur.execute("drop view recommendation_pt;")
    return render_template('pt_recommendation.html', pts=result)

@app.route('/print_total_body',methods=['GET'])
def print_total_body():
    cur.execute("SELECT * From body_info;")
    total_body=cur.fetchall()
    return render_template("total_body.html", bodies=total_body)

@app.route('/specific_body',methods=['POST'])
def specific_body():
    m_id = request.form["id"]

    cur.execute("create view f_l_body as "
                "Select member_id as m_id, min(measure_date) as f_date, max(measure_date) as l_date "
                "From body_info group by member_id;")

    cur.execute("create view f_body as "
                "Select f_date, member_id, height, weight, fat_percentage, muscle_mass "
                "from f_l_body, body_info "
                "where f_l_body.f_date=body_info.measure_date and f_l_body.m_id=body_info.member_id and "
                "f_l_body.m_id=\'" + m_id + "\';")
    cur.execute("select * from f_body;")
    first_date_body=cur.fetchall()

    cur.execute("create view l_body as "
                "Select l_date, member_id, height, weight, fat_percentage, muscle_mass "
                "from f_l_body, body_info "
                "where f_l_body.l_date=body_info.measure_date and f_l_body.m_id=body_info.member_id and "
                "f_l_body.m_id=\'" + m_id + "\';")
    cur.execute("select * from l_body;")
    last_date_body = cur.fetchall()

    cur.execute("Select f_body.member_id, (l_body.height-f_body.height), (l_body.weight-f_body.weight), "
                "(l_body.fat_percentage-f_body.fat_percentage), (l_body.muscle_mass-f_body.muscle_mass) "
                "from f_body, l_body;")
    body_change = cur.fetchall()

    cur.execute("drop view f_body;")
    cur.execute("drop view l_body;")
    cur.execute("drop view f_l_body;")

    return render_template("specific_body.html", f_body=first_date_body, l_body=last_date_body, changed_body=body_change)



if __name__ == '__main__':
    app.run()