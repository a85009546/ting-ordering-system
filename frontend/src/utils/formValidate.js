// 格式化時間
const formatDate = () => {
  const now = new Date();
  let hour = now.getHours();
  let minute = now.getMinutes();
  let second = now.getSeconds();
  if (hour < 10) hour = `0${hour}`;
  if (minute < 10) minute = `0${minute}`;
  if (second < 10) second = `0${second}`;
  return `${hour}:${minute}:${second}`;
};

// 日期格式化函式
function dateFormat(fmt, time) {
  let date = new Date(time);
  let ret;
  const opt = {
    "Y+": date.getFullYear().toString(),
    "m+": (date.getMonth() + 1).toString(),
    "d+": date.getDate().toString()
  };
  for (const k in opt) {
    ret = new RegExp("(" + k + ")").exec(fmt);
    if (ret) {
      fmt = fmt.replace(
        ret[1],
        ret[1].length === 1 ? opt[k] : opt[k].padStart(ret[1].length, "0")
      );
    }
  }
  return fmt;
}

// 獲取昨日日期範圍
export const get1stAndToday = () => {
  let toData = new Date(new Date().toLocaleDateString()).getTime();
  let yesterdayStart = toData - 3600 * 24 * 1000;
  let yesterdayEnd = yesterdayStart + 24 * 60 * 60 * 1000 - 1;
  let startDay1 = dateFormat("YYYY-mm-dd", yesterdayStart);
  let endDay1 = dateFormat("YYYY-mm-dd", yesterdayEnd);
  return [startDay1, endDay1];
};

// 獲取昨日與今日日期
const getday = () => {
  let toData = new Date(new Date().toLocaleDateString()).getTime();
  let yesterdays = toData - 3600 * 24 * 1000;
  let yesterday = dateFormat("YYYY.mm.dd", yesterdays);
  let today = dateFormat("YYYY.mm.dd", toData);
  return [yesterday, today];
};

// 獲取近7日日期範圍
export const past7Day = () => {
  let toData = new Date(new Date().toLocaleDateString()).getTime();
  let past7daysStart = toData - 7 * 3600 * 24 * 1000;
  let past7daysEnd = toData - 1;
  let days7Start = dateFormat("YYYY-mm-dd", past7daysStart);
  let days7End = dateFormat("YYYY-mm-dd", past7daysEnd);
  return [days7Start, days7End];
};

// 獲取近30日日期範圍
export const past30Day = () => {
  let toData = new Date(new Date().toLocaleDateString()).getTime();
  let past30daysStart = toData - 30 * 3600 * 24 * 1000;
  let past30daysEnd = toData - 1;
  let days30Start = dateFormat("YYYY-mm-dd", past30daysStart);
  let days30End = dateFormat("YYYY-mm-dd", past30daysEnd);
  return [days30Start, days30End];
};

// 獲取本周日期範圍
export const pastWeek = () => {
  let toData = new Date(new Date().toLocaleDateString()).getTime();
  let nowDayOfWeek = new Date().getDay();
  const weekStartData = toData - (nowDayOfWeek - 1) * 24 * 60 * 60 * 1000;
  const weekEndData = toData + (7 - nowDayOfWeek) * 24 * 60 * 60 * 1000;
  let weekStart = dateFormat("YYYY-mm-dd", weekStartData);
  let weekEnd = dateFormat("YYYY-mm-dd", weekEndData);
  return [weekStart, weekEnd];
};

// 獲取本月日期範圍
export const pastMonth = () => {
  let year = new Date().getFullYear();
  let month = new Date().getMonth();
  const monthStartData = new Date(year, month, 1).getTime();
  const monthEndData = new Date(year, month + 1, 0).getTime() + 24 * 60 * 60 * 1000 - 1;
  let monthStart = dateFormat("YYYY-mm-dd", monthStartData);
  let monthEnd = dateFormat("YYYY-mm-dd", monthEndData);
  return [monthStart, monthEnd];
};
