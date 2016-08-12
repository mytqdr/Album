package net;

/**
 * <p>Title:
 *ͼ����ʾ���ֺ�,�����ֱ�����SESSION��,SESSION������ΪGET����������(sessionName=����).��û������ʱ
 * ��ΪĬ��Ϊrand</p>
 * <p>Description: </p>
 * web.xml������.


  <servlet>
    <servlet-name>randCodeImage</servlet-name>
    <servlet-class>iclass.image.RandCodeImage</servlet-class>
  </servlet>
  <servlet-mapping>
    <servlet-name>randCodeImage</servlet-name>
    <url-pattern>/randCodeImage</url-pattern>
  </servlet-mapping>



 * <p>Copyright: Copyright (c) 2004</p>
 *
 * <p>Company: </p>
 *
 * @author not attributable
 * @version 1.0
 */

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;



/**
 * ������
 *
 * @author $author$
 * @version $Revision: 1.1 $
 */
public class RandCodeImage extends HttpServlet {

    private Font mFont = new Font("Arial Black", Font.PLAIN, 15); //��������
    private int lineWidth = 2; //�����ߵĳ���=1.414*lineWidth
    private int width = 60; //����ͼ�δ�С
    private int height = 20; //����ͼ�δ�С
    private int count = 200;

    /**
     * ������
     *
     * @param fc ������
     * @param bc ������
     *
     * @return ������
     */
    private Color getRandColor(int fc, int bc) { //ȡ�ø�����Χ�����ɫ


        HttpServletRequest request;

        Random random = new Random();

        if (fc > 255) {

            fc = 255;
        }

        if (bc > 255) {

            bc = 255;
        }

        int r = fc + random.nextInt(bc - fc);
        int g = fc + random.nextInt(bc - fc);
        int b = fc + random.nextInt(bc - fc);

        return new Color(r, g, b);
    }

    //����post
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {

        doGet(request, response);
    }

    /**
     * ������
     *
     * @param request ������
     * @param response ������
     *
     * @throws ServletException ������
     * @throws IOException ������
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {

        //ͼ����ʾ���ֺ�,�����ֱ�����SESSION��,SESSION������ΪGET����������
        String sessionName=(String)request.getParameter("sessionName");
        if(sessionName==null||sessionName.length()==0){
            sessionName="rand";
        }

        //response.reset();
        //����ҳ�治����
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        response.setContentType("image/png");

        // ���ڴ��д���ͼ��
        BufferedImage image = new BufferedImage(width, height,
                                                BufferedImage.TYPE_INT_RGB);

        // ��ȡͼ��������
        Graphics2D g = (Graphics2D) image.getGraphics();

        //���������
        Random random = new Random();

        // �趨����ɫ
        g.setColor(getRandColor(200, 250)); //---1

        g.fillRect(0, 0, width, height);

        //�趨����
        g.setFont(mFont);

        //���߿�
        g.setColor(getRandColor(0, 20)); //---2
        g.drawRect(0, 0, width - 1, height - 1);

        //������������ߣ�ʹͼ���е���֤�벻�ױ���������̽�⵽
        for (int i = 0; i < count; i++) {

            g.setColor(getRandColor(150, 200)); //---3

            int x = random.nextInt(width - lineWidth - 1) + 1; //��֤���ڱ߿�֮��
            int y = random.nextInt(height - lineWidth - 1) + 1;
            int xl = random.nextInt(lineWidth);
            int yl = random.nextInt(lineWidth);
            g.drawLine(x, y, x + xl, y + yl);
        }

        //ȡ�����������֤��(4λ����)
        String sRand = "";

        for (int i = 0; i < 4; i++) {

            String rand = String.valueOf(random.nextInt(10));
            sRand += rand;

            // ����֤����ʾ��ͼ����,���ú�����������ɫ��ͬ����������Ϊ����̫�ӽ�������ֻ��ֱ������
            g.setColor(new Color(20 + random.nextInt(130),
                                 20 + random.nextInt(130),
                                 20 + random.nextInt(130))); //--4--50-100

            g.drawString(rand, (13 * i) + 6, 16);

        }

        // ����֤�����SESSION
        request.getSession().setAttribute(sessionName, sRand);
        // ͼ����Ч
        g.dispose();

        // ���ͼ��ҳ��
        ImageIO.write(image, "PNG", response.getOutputStream());
    }
}
