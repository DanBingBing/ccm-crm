package com.study.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用的返回json数据的类
 * @author danbingbing
 *
 */
public class Message {
	// 状态码 100-失败  200-成功
	private int code;
	// 提示信息
	private String message;
	// 用户要返回给浏览器的数据
	private Map<String, Object> extend = new HashMap<>();
	
	public static Message success() {
		Message result = new Message();
		result.setCode(200);
		result.setMessage("处理成功！");
		return result;
	}
	
	public static Message failed() {
		Message result = new Message();
		result.setCode(100);
		result.setMessage("处理失败！");
		return result;
	}
	
	// 可链式操作：.add().add() ...
	public Message add(String key, Object value) {
		this.getExtend().put(key, value);
		return this;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Map<String, Object> getExtend() {
		return extend;
	}

	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}
	
}
