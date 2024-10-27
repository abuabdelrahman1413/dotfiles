#!/usr/bin/env python3
from hijri_converter import convert
from datetime import datetime
#
# today = convert.Gregorian.today().to_hijri()
# print(type(today))
#
#
# تعريف قائمة بأسماء الأشهر الهجرية
months = [
    "محرم", "صفر", "ربيع أول", "ربيع ثاني", "جمادى أول", "جمادى ثاني",
    "رجب", "شعبان", "رمضان", "شوال", "ذو القعدة", "ذو الحجة"
]
def hijri_day():
    today = datetime.today()
    hijri = convert.Gregorian(today.year, today.month, today.day).to_hijri()
    return f"{hijri.day}"

def hijri_month():
    today = datetime.today()
    hijri = convert.Gregorian(today.year, today.month, today.day).to_hijri()
    month_name = months[hijri.month - 1]
    return f"{month_name}"

def hijri_year():
    today = datetime.today()
    hijri = convert.Gregorian(today.year, today.month, today.day).to_hijri()
    return f"{hijri.year}"
