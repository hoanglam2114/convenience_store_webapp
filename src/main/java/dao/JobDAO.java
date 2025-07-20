/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Job;
import model.JobCategories;
import model.JobDetail;
import model.JobLocation;
import model.JobTypes;

/**
 *
 * @author admin
 */
public class JobDAO extends DBContext {

    public List<Job> getAllJob() {
        List<Job> listJobs = new ArrayList<>();
        String sql = "SELECT  [jobID]\n"
                + "      ,[jobTitle]\n"
                + "      ,[jobType_ID]\n"
                + "      ,[location_ID]\n"
                + "      ,[deadline]\n"
                + "      ,[createdDate]\n"
                + "      ,[jobCategory_ID]\n"
                + "      ,[description]\n"
                + "      ,[status]\n"
                + "  FROM [dbo].[JobPostings]\n"
                + "  where 1=1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Job p = new Job();
                p.setId(rs.getInt("jobID"));
                p.setTitle(rs.getString("jobTitle"));
                JobTypes jt = getTypesById(rs.getInt("jobType_ID"));
                p.setJobTypes(jt);
                JobLocation wu = getJobLocationById(rs.getInt("location_ID"));
                p.setJobLocation(wu);
                p.setDeadline(rs.getDate("deadline").toLocalDate());
                p.setCreatedDate(rs.getTimestamp("createdDate").toLocalDateTime());
                JobCategories sup = getJobCategoriesById(rs.getInt("jobCategory_ID"));
                p.setJobCategories(sup);
                p.setDescription(rs.getString("description"));
                p.setStatus(rs.getString("status"));
                listJobs.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listJobs;
    }

    public JobLocation getJobLocationById(int jobLocation_id) {
        String sql = "select * from [dbo].[Locations] where location_ID = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, jobLocation_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                JobLocation wu = new JobLocation(rs.getInt("location_ID"),
                        rs.getString("location_Name")
                );
                return wu;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<JobLocation> getAllJobLocation() {
        List<JobLocation> list = new ArrayList<>();
        String sql = "select * from [dbo].[Locations]";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                JobLocation wu = new JobLocation(rs.getInt("location_ID"),
                        rs.getString("location_Name")
                );
                list.add(wu);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public JobCategories getJobCategoriesById(int jobcategory_id) {
        String sql = "select * from [dbo].[JobCategories] where jobCategory_ID = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, jobcategory_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                JobCategories pc = new JobCategories(rs.getInt("jobCategory_ID"),
                        rs.getString("jobCategory_Name"));
                return pc;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<JobCategories> getAllJobCategories() {
        List<JobCategories> list = new ArrayList<>();
        String sql = "select * from [dbo].[JobCategories]";

        try {
            PreparedStatement st = connection.prepareStatement(sql);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                JobCategories pc = new JobCategories(rs.getInt("jobCategory_ID"),
                        rs.getString("jobCategory_Name"));
                list.add(pc);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public JobTypes getTypesById(int jobtypes_id) {
        String sql = "select * from [dbo].[JobTypes] where jobType_ID = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, jobtypes_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                JobTypes wi = new JobTypes(rs.getInt("jobType_ID"),
                        rs.getString("jobType_Name"));
                return wi;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<JobTypes> getAllTypes() {
        List<JobTypes> list = new ArrayList<>();
        String sql = "select * from [dbo].[JobTypes]";

        try {
            PreparedStatement st = connection.prepareStatement(sql);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                JobTypes wi = new JobTypes(rs.getInt("jobType_ID"),
                        rs.getString("jobType_Name"));
                list.add(wi);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public int getTotalJob() {
        String sql = "select COUNT(*) from [dbo].[JobPostings]";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public List<Job> pagingJobs(int index) {
        List<Job> list = new ArrayList<>();
        String sql = "SELECT  [jobID]\n"
                + "      ,[jobTitle]\n"
                + "      ,[jobType_ID]\n"
                + "      ,[location_ID]\n"
                + "      ,[deadline]\n"
                + "      ,[createdDate]\n"
                + "      ,[jobCategory_ID]\n"
                + "      ,[description]\n"
                + "      ,[status]\n"
                + "  FROM [dbo].[JobPostings]\n"
                + "  ORDER BY jobID offset ? rows fetch next 5 rows only";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, (index - 1) * 5);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Job p = new Job();
                p.setId(rs.getInt("jobID"));
                p.setTitle(rs.getString("jobTitle"));
                JobTypes jt = getTypesById(rs.getInt("jobType_ID"));
                p.setJobTypes(jt);
                JobLocation wu = getJobLocationById(rs.getInt("location_ID"));
                p.setJobLocation(wu);
                p.setDeadline(rs.getDate("deadline").toLocalDate());
                p.setCreatedDate(rs.getTimestamp("createdDate").toLocalDateTime());
                JobCategories sup = getJobCategoriesById(rs.getInt("jobCategory_ID"));
                p.setJobCategories(sup);
                p.setDescription(rs.getString("description"));
                p.setStatus(rs.getString("status"));
                list.add(p);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }

    public void insertJob(Job p) {
        String sql = "INSERT INTO [dbo].[JobPostings] VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, p.getTitle());
            st.setInt(2, p.getJobTypes().getId());
            st.setInt(3, p.getJobLocation().getId());
            st.setDate(4, java.sql.Date.valueOf(p.getDeadline()));
            st.setTimestamp(5, Timestamp.valueOf(p.getCreatedDate()));
            st.setInt(6, p.getJobCategories().getId());
            st.setString(7, p.getDescription());
            st.setString(8, p.getStatus());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateJob(Job p) {
        String sql = "UPDATE [dbo].[JobPostings]\n"
                + "   SET [jobTitle] = ?\n"
                + "      ,[jobType_ID] = ?\n"
                + "      ,[location_ID] = ?\n"
                + "      ,[deadline] = ?\n"
                + "      ,[createdDate] = ?\n"
                + "      ,[jobCategory_ID] = ?\n"
                + "      ,[description] = ?\n"
                + "      ,[status] = ?\n"
                + " WHERE jobID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, p.getTitle());
            st.setInt(2, p.getJobTypes().getId());
            st.setInt(3, p.getJobLocation().getId());
            st.setDate(4, java.sql.Date.valueOf(p.getDeadline()));
            st.setTimestamp(5, Timestamp.valueOf(p.getCreatedDate()));
            st.setInt(6, p.getJobCategories().getId());
            st.setString(7, p.getDescription());
            st.setString(8, p.getStatus());
            st.setInt(9, p.getId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<String> getStatuses() {
        List<String> statuses = new ArrayList<>();
        statuses.add("Open");
        statuses.add("Close");
        return statuses;
    }

    public Job getJobById(int job_id) {
        String sql = "select * from [dbo].[JobPostings] where jobID = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, job_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Job p = new Job();
                p.setId(rs.getInt("jobID"));
                p.setTitle(rs.getString("jobTitle"));
                JobTypes jt = getTypesById(rs.getInt("jobType_ID"));
                p.setJobTypes(jt);
                JobLocation wu = getJobLocationById(rs.getInt("location_ID"));
                p.setJobLocation(wu);
                p.setDeadline(rs.getDate("deadline").toLocalDate());
                p.setCreatedDate(rs.getTimestamp("createdDate").toLocalDateTime());
                JobCategories sup = getJobCategoriesById(rs.getInt("jobCategory_ID"));
                p.setJobCategories(sup);
                p.setDescription(rs.getString("description"));
                p.setStatus(rs.getString("status"));

                return p;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Job> filterJobs(String jobTitle, LocalDate deadline, String status) {
        List<Job> jobs = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT * "
                + "FROM [JobPostings] WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (jobTitle != null && !jobTitle.trim().isEmpty()) {
            sql.append("AND jobTitle LIKE ? ");
            params.add("%" + jobTitle.trim() + "%");
        }

        if (deadline != null) {
            sql.append("AND deadline = ? ");
            params.add(Date.valueOf(deadline));
        }

        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND status = ? ");
            params.add(status.trim());
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Job p = new Job();
                    p.setId(rs.getInt("jobID"));
                    p.setTitle(rs.getString("jobTitle"));
                    JobTypes jt = getTypesById(rs.getInt("jobType_ID"));
                    p.setJobTypes(jt);
                    JobLocation wu = getJobLocationById(rs.getInt("location_ID"));
                    p.setJobLocation(wu);
                    p.setDeadline(rs.getDate("deadline").toLocalDate());
                    p.setCreatedDate(rs.getTimestamp("createdDate").toLocalDateTime());
                    JobCategories sup = getJobCategoriesById(rs.getInt("jobCategory_ID"));
                    p.setJobCategories(sup);
                    p.setDescription(rs.getString("description"));
                    p.setStatus(rs.getString("status"));

                    jobs.add(p);
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return jobs;
    }

    public List<Job> filterJobsCustomer(String jobTitle, Integer jobTypeID, Integer locationID) {
        List<Job> jobs = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT *"
                + "FROM [JobPostings] WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (jobTitle != null && !jobTitle.trim().isEmpty()) {
            sql.append("AND jobTitle LIKE ? ");
            params.add("%" + jobTitle.trim() + "%");
        }
        if (jobTypeID != null) {
            sql.append("AND jobType_ID = ? ");
            params.add(jobTypeID);
        }
        if (locationID != null) {
            sql.append("AND location_ID = ? ");
            params.add(locationID);
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Job p = new Job();
                    p.setId(rs.getInt("jobID"));
                    p.setTitle(rs.getString("jobTitle"));
                    JobTypes jt = getTypesById(rs.getInt("jobType_ID"));
                    p.setJobTypes(jt);
                    JobLocation wu = getJobLocationById(rs.getInt("location_ID"));
                    p.setJobLocation(wu);
                    p.setDeadline(rs.getDate("deadline").toLocalDate());
                    p.setCreatedDate(rs.getTimestamp("createdDate").toLocalDateTime());
                    JobCategories sup = getJobCategoriesById(rs.getInt("jobCategory_ID"));
                    p.setJobCategories(sup);
                    p.setDescription(rs.getString("description"));
                    p.setStatus(rs.getString("status"));

                    jobs.add(p);
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return jobs;
    }

    public List<JobDetail> getJobDetailTextById(int job_id) {
        List<JobDetail> list = new ArrayList<>();
        String sql = "select * from JobDetails where jobID = ? ORDER BY id ";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, job_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                JobDetail p = new JobDetail();
                p.setId(rs.getInt("id"));
                p.setJobid(rs.getInt("jobID"));
                p.setTexttitle(rs.getString("title"));
                p.setTextcontent(rs.getString("content"));
                p.setSortorder(rs.getInt("sort_order"));

                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void deleteJob(int id) {
        String sql = "delete from [dbo].[JobPostings] where jobID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        JobDAO jd = new JobDAO();
        List<JobDetail> list = jd.getJobDetailTextById(1);
        for (JobDetail jobDetail : list) {
            System.out.println(jobDetail);
        }

    }

}
