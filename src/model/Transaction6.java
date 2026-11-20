package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Transaction6 {
    private int id;
    private Date createdDate;
    private float totalAmount;
    private List<TransactionDetail6> listTransactionDetail;

    public Transaction6() {
        this.listTransactionDetail = new ArrayList<>();
    }

    public Transaction6(int id, Date createdDate, float totalAmount) {
        this.id = id;
        this.createdDate = createdDate;
        this.totalAmount = totalAmount;
        this.listTransactionDetail = new ArrayList<>();
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }

    public float getTotalAmount() { return totalAmount; }
    public void setTotalAmount(float totalAmount) { this.totalAmount = totalAmount; }

    public List<TransactionDetail6> getListTransactionDetail() { return listTransactionDetail; }
    public void setListTransactionDetail(List<TransactionDetail6> listTransactionDetail) {
        this.listTransactionDetail = listTransactionDetail;
    }
}
