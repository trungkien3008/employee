<%@ page import="nlu.edu.vn.employee.services.EmployeeService" %>
<%@ page import="nlu.edu.vn.employee.models.Employee" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String employeeId = request.getParameter("id");
    Employee employee = EmployeeService.getInstance().getEmployeeById(employeeId);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lí nhân viên</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
          crossorigin="anonymous">
</head>
<body>

<div style="height: 100vh" class="container">
    <div >
        <h1 style="margin-top: 40px;margin-bottom: 20px" class="row justify-content-center">Sửa thông tin nhân viên</h1>

        <div class="d-flex justify-content-center">
            <form id="addEmployeeForm">

                <div class="form-group">
                    <label class="col-form-label">Mã nhân viên </label>
                    <input  disabled value="${employee.id}" class="form-control" required type="text"
                           name="id" placeholder="Nhập mã nhân viên">
                </div>
                <div class="form-group">
                    <label class="col-form-label">Họ tên </label>
                    <input  value="${employee.name}" class="form-control" required type="text"
                           name="name" placeholder="Nhập họ tên">
                </div>
                <div class="form-group">
                    <label class="col-form-label">Giới tính</label>
                    <input type="radio" name="male" value="true" ${employee.isMale()  ? "checked":""}> Nam
                    <input type="radio" name="male" value="false" ${!employee.isMale() ? "checked":""}> Nữ
                </div>
                <div class="form-group">
                    <label class="col-form-label">Ngày sinh</label>
                    <input  class="form-control" value="${employee.birthday}" required type="date" name="birthday"
                           placeholder="vd: 01/02/2001">
                </div>
                <div class="form-group">
                    <label class="col-form-label">Địa chỉ</label>
                    <input  class="form-control" value="${employee.address}" required type="text" name="address"
                           placeholder="Nhập địa chỉ">
                </div>
                <div class="form-group">
                    <label class="col-form-label">Số điện thoại </label>
                    <input  value="${employee.phone}" class="form-control" required type="text" name="phone"
                           placeholder="Nhập số điện thoại">
                </div>
                <div class="form-group">
                    <label class="col-form-label">Phòng ban</label>
                    <input  value="${employee.department}" class="form-control" required type="text" name="department"
                           placeholder="Nhập phòng ban">
                </div>
                <div class="form-group">
                    <label class="col-form-label">Chức vụ</label>
                    <input  value="${employee.title}" class="form-control" required type="text" name="title"
                           placeholder="Nhập chức vụ">
                </div>
                <div class="form-group">
                    <label class="col-form-label">Mức lương</label>
                    <input  value="${employee.wageRate}" class="form-control" required type="number" name="wageRate"
                           placeholder="Nhập mức lương">
                </div>
                <button onClick="updateEmployee()" type="button" class="btn btn-primary">Cập nhật</button>
                <a href="/" type="button" class="btn btn-light">Hủy</a>
            </form>


        </div>
    </div>
</div>
<script>
    function updateEmployee() {
        const id = $('input[name="id"]').val();
        const name = $('input[name="name"]').val();
        const male = $('input[name="male"]:checked').val();
        const birthday = $('input[name="birthday"]').val();
        const address = $('input[name="address"]').val();
        const phone = $('input[name="phone"]').val();
        const department = $('input[name="department"]').val();
        const title = $('input[name="title"]').val();
        const wageRate = $('input[name="wageRate"]').val();


        const data = {
            "id": id,
            "name": name,
            "male": male,
            "birthday": birthday,
            "address": address,
            "phone": phone,
            "department": department,
            "title": title,
            "wageRate": wageRate
        };


        if (!id || !name || !male || !birthday || !address || !phone || !department || !title || !wageRate) {
            alert('Vui lòng nhập đầy đủ thông tin!');
            return;
        } else {
            $.ajax({
                url: '/suanhanvien',
                type: 'POST',
                data: JSON.stringify(data),
                contentType: 'application/json',
                success: function (response) {
                    console.log(response)
                    if (response === 'success') {
                        window.location.href='http://localhost:8080/';
                        alert('Sửa thông tin nhân viên thành công');
                    } else {
                        alert('Mã nhân viên đã tồn tại');
                    }
                }
            });
        }


    }
</script>


<script src="https://code.jquery.com/jquery-3.1.1.min.js">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>

</body>
</html>
