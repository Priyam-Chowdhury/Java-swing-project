package signupform;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import java.awt.Color;
import javax.swing.JTextField;
import javax.swing.JPasswordField;
import javax.swing.JLabel;
import javax.swing.JOptionPane;

import java.awt.Font;
import javax.swing.JButton;
import javax.swing.UIManager;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.awt.event.ActionEvent;

public class login extends JFrame {

	private JPanel contentPane;
	private JTextField tfUserid;
	private JPasswordField tfPassword;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					login frame = new login();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	Connection con=null;
	public login() {
		con=DB.dbconnect();
		if(con==null)
		{
			JOptionPane.showMessageDialog(this, "Database not available", "Error",JOptionPane.ERROR_MESSAGE);
		}
		else
		{
			
		}
		
		
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 393, 300);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));

		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JPanel panel = new JPanel();
		panel.setBackground(Color.RED);
		panel.setBounds(0, 0, 434, 72);
		contentPane.add(panel);
		panel.setLayout(null);
		
		JLabel lblNewLabel_5 = new JLabel("LOGIN");
		lblNewLabel_5.setBounds(144, 35, 122, 26);
		panel.add(lblNewLabel_5);
		lblNewLabel_5.setFont(new Font("Verdana", Font.BOLD | Font.ITALIC, 14));
		
		JPanel panel_1 = new JPanel();
		panel_1.setBackground(UIManager.getColor("Button.shadow"));
		panel_1.setBounds(0, 71, 434, 190);
		contentPane.add(panel_1);
		panel_1.setLayout(null);
		
		tfUserid = new JTextField();
		tfUserid.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
			}
		});
		tfUserid.setColumns(10);
		tfUserid.setBounds(178, 34, 107, 26);
		panel_1.add(tfUserid);
		
		tfPassword = new JPasswordField();
		tfPassword.setBounds(178, 79, 107, 26);
		panel_1.add(tfPassword);
		
		JLabel lblNewLabel_2 = new JLabel("USER ID");
		lblNewLabel_2.setFont(new Font("Sitka Small", Font.BOLD | Font.ITALIC, 12));
		lblNewLabel_2.setBounds(64, 36, 81, 26);
		panel_1.add(lblNewLabel_2);
		
		JLabel lblNewLabel_3 = new JLabel("PASSWORD");
		lblNewLabel_3.setFont(new Font("Sitka Small", Font.BOLD | Font.ITALIC, 12));
		lblNewLabel_3.setBounds(64, 81, 79, 26);
		panel_1.add(lblNewLabel_3);
		
		JButton btnLogin = new JButton("Login in");
		btnLogin.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				String userid=tfUserid.getText();
				String password=String.valueOf(tfPassword.getPassword());
				if(userid.isEmpty() || password.isEmpty())
				{
					JOptionPane.showMessageDialog(btnLogin, "Userid/Password should not be empty", "Error",JOptionPane.ERROR_MESSAGE);
				}
				else
				{
					//Starting login process
					try {
						userLogin(userid,password);
					} catch (SQLException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
				}
			}

			private void userLogin(String userid, String password) throws SQLException {
				// TODO Auto-generated method stub
				Connection con=DB.dbconnect();
				if(con != null)
				{
				try
				{
				PreparedStatement st=con.prepareStatement("select * from signup where userid=? and password=?");
				
				
				
				
				st.setString(1, userid);
				st.setString(2, password);
				ResultSet res=st.executeQuery();
				if(res.next())
				{
					dispose();
					Dashboard d=new Dashboard();
					d.setTitle("Dashboard");
					d.setVisible(true);
				}
				else
				{
					JOptionPane.showMessageDialog(btnLogin, "Userid/password not found", "Error",JOptionPane.ERROR_MESSAGE);
				}
				}
				catch(SQLException e) {
					Logger.getLogger(login.class.getName()).log(Level.SEVERE,null,e);
				}
				}else
				{
					System.out.println("The connection not available");
				}
			}
		});
		btnLogin.setBackground(new Color(0, 0, 0));
		btnLogin.setBounds(134, 129, 89, 23);
		panel_1.add(btnLogin);
	}
}
