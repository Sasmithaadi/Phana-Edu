package com.pahanaedu.dao;

import com.pahanaedu.model.Bill;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

public class BillDAO {

    private static final Map<Integer, Bill> STORE = new ConcurrentHashMap<>();
    private static final AtomicInteger ID_SEQ = new AtomicInteger(1000);

    public int nextId() {
        return ID_SEQ.incrementAndGet();
    }

    public void save(Bill bill) {
        STORE.put(bill.getBillId(), bill);
    }

    public void update(Bill bill) {
        STORE.put(bill.getBillId(), bill);
    }

    public void delete(int billId) {
        STORE.remove(billId);
    }

    public Bill findById(int billId) {
        return STORE.get(billId);
    }

    public List<Bill> findAll() {
        List<Bill> list = new ArrayList<>(STORE.values());
        list.sort(Comparator.comparingInt(Bill::getBillId)); // stable list
        return list;
    }
}
