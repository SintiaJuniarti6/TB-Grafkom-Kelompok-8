#include <GL/glut.h>
#include <math.h>

float ballPosX = 0.0f, ballPosY = 0.3f, ballPosZ = 2.5f;
float rotationAngle = 0.0f;  // Rotasi gawang
bool isRotating = true;      // Flag untuk kontrol rotasi otomatis gawang
bool hidden = false;         // Flag untuk mengontrol apakah garis kartesius ditampilkan
float globalScale = 1.0f;    // Variabel untuk mengontrol skala seluruh objek

void init() {
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
    glEnable(GL_COLOR_MATERIAL);
    glEnable(GL_NORMALIZE);
    glClearColor(0.2f, 0.3f, 0.3f, 1.0f);

    GLfloat lightPosition[] = { 2.0f, 4.0f, 2.0f, 1.0f };
    GLfloat lightAmbient[]  = { 0.2f, 0.2f, 0.2f, 1.0f };
    GLfloat lightDiffuse[]  = { 0.8f, 0.8f, 0.8f, 1.0f };
    GLfloat lightSpecular[] = { 1.0f, 1.0f, 1.0f, 1.0f };

    glLightfv(GL_LIGHT0, GL_POSITION, lightPosition);
    glLightfv(GL_LIGHT0, GL_AMBIENT, lightAmbient);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, lightDiffuse);
    glLightfv(GL_LIGHT0, GL_SPECULAR, lightSpecular);

    GLfloat matSpecular[] = { 1.0f, 1.0f, 1.0f, 1.0f };
    GLfloat matShininess[] = { 50.0f };
    glMaterialfv(GL_FRONT, GL_SPECULAR, matSpecular);
    glMaterialfv(GL_FRONT, GL_SHININESS, matShininess);
}


//////////////////////////////////////////////////////////////////////////// BAGIAN SINTIA////////////////////////////////////////////////
// Fungsi untuk menggambar sumbu kartesius
void drawCartesius() {
    glDisable(GL_LIGHTING); // Matikan pencahayaan sementara untuk garis
    glLineWidth(2.0f);

    glBegin(GL_LINES);
    // Sumbu X (Merah)
    glColor3f(1.0f, 0.0f, 0.0f);
    glVertex3f(-20.0f, 0.0f, 0.0f);
    glVertex3f(20.0f, 0.0f, 0.0f);

    // Sumbu Y (Hijau)
    glColor3f(0.0f, 1.0f, 0.0f);
    glVertex3f(0.0f, -20.0f, 0.0f);
    glVertex3f(0.0f, 20.0f, 0.0f);

    // Sumbu Z (Biru)
    glColor3f(0.0f, 0.0f, 1.0f);
    glVertex3f(0.0f, 0.0f, -20.0f);
    glVertex3f(0.0f, 0.0f, 20.0f);
    glEnd();

    

    glEnable(GL_LIGHTING); // Nyalakan kembali pencahayaan
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




////////////////////////////////////////////////////////////////////////////////BAGIAN GINA////////////////////////////////////////////////////
void gambarnet() {
    glColor3f(0.9f, 0.9f, 0.9f);
    float spacing = 0.2f; // Jarak antar garis jaring 

    // Belakang
    for (float x = -1.5f; x <= 1.5f; x += spacing) {
        glBegin(GL_LINES);
        glVertex3f(x, 0.0f, -1.0f);
        glVertex3f(x, 2.0f, -1.0f);
        glEnd();
    }
    for (float y = 0.0f; y <= 2.0f; y += spacing) {
        glBegin(GL_LINES);
        glVertex3f(-1.5f, y, -1.0f);
        glVertex3f(1.5f, y, -1.0f);
        glEnd();
    }
    // Jaring bagian kiri
    for (float z = 0.0f; z >= -1.0f; z -= spacing) {
        glBegin(GL_LINES);
        glVertex3f(-1.5f, 0.0f, z);
        glVertex3f(-1.5f, 2.0f, z);
        glEnd();
    }
    for (float y = 0.0f; y <= 2.0f; y += spacing) {
        glBegin(GL_LINES);
        glVertex3f(-1.5f, y, 0.0f);
        glVertex3f(-1.5f, y, -1.0f);
        glEnd();
    }
    // Kanan 
    for (float z = 0.0f; z >= -1.0f; z -= spacing) {
        glBegin(GL_LINES);
        glVertex3f(1.5f, 0.0f, z);
        glVertex3f(1.5f, 2.0f, z);
        glEnd();
    }
    for (float y = 0.0f; y <= 2.0f; y += spacing) {
        glBegin(GL_LINES);
        glVertex3f(1.5f, y, 0.0f);
        glVertex3f(1.5f, y, -1.0f);
        glEnd();
    }
    // Atas
    for (float x = -1.5f; x <= 1.5f; x += spacing) {
        glBegin(GL_LINES);
        glVertex3f(x, 2.0f, 0.0f);
        glVertex3f(x, 2.0f, -1.0f);
        glEnd();
    }
    for (float z = 0.0f; z >= -1.0f; z -= spacing) {
        glBegin(GL_LINES);
        glVertex3f(-1.5f, 2.0f, z);
        glVertex3f(1.5f, 2.0f, z);
        glEnd();
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////// BAGIAN SINTIA///////////////////////////////////////////////////////////////
void gambarBall() {
    glColor3f(1.0f, 1.0f, 0.0f);
    glPushMatrix();
    glTranslatef(ballPosX, ballPosY, ballPosZ);
    glutSolidSphere(0.3f, 50, 50);
    glPopMatrix();
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////// BAGIAN GINA /////////////////////////////////////////////////////////
void gambartianggawang() {
    glColor3f(1.0f, 1.0f, 1.0f);
    
    // Tiang kiri depan
    glPushMatrix();
    glTranslatef(-1.5f, 1.0f, 0.0f);
    glScalef(0.1f, 2.0f, 0.1f);
    glutSolidCube(1.0f);
    glPopMatrix();
    
    // Tiang kanan depan
    glPushMatrix();
    glTranslatef(1.5f, 1.0f, 0.0f);
    glScalef(0.1f, 2.0f, 0.1f);
    glutSolidCube(1.0f);
    glPopMatrix();
    
    // Tiang kanan belakang
    glPushMatrix();
    glTranslatef(1.5f, 1.0f, -1.0f);
    glScalef(0.1f, 2.0f, 0.1f);
    glutSolidCube(1.0f);
    glPopMatrix();
    
    // Tiang kiri belakang
    glPushMatrix();
    glTranslatef(-1.5f, 1.0f, -1.0f);
    glScalef(0.1f, 2.0f, 0.1f);
    glutSolidCube(1.0f);
    glPopMatrix();

    // Tiang atas depan
    glPushMatrix();
    glTranslatef(0.0f, 2.0f, 0.0f);
    glScalef(3.0f, 0.1f, 0.1f);
    glutSolidCube(1.0f);
    glPopMatrix();
    
    // Tiang atas belakang
    glPushMatrix();
    glTranslatef(0.0f, 2.0f, -1.0f);
    glScalef(3.0f, 0.1f, 0.1f);
    glutSolidCube(1.0f);
    glPopMatrix();

    // Tiang kiri bawah
    glPushMatrix();
    glTranslatef(-1.5f, 0.0f, -0.5f);
    glScalef(0.1f, 0.1f, 1.0f);
    glutSolidCube(1.0f);
    glPopMatrix();
    
    // Tiang atas kanan
    glPushMatrix();
    glTranslatef(1.5f, 2.0f, -0.5f);
    glScalef(0.1f, 0.1f, 1.11f);
    glutSolidCube(1.0f);
    glPopMatrix();
    
    // Tiang atas kiri
    glPushMatrix();
    glTranslatef(-1.5f, 2.0f, -0.5f);
    glScalef(0.1f, 0.1f, 1.11f);
    glutSolidCube(1.0f);
    glPopMatrix();

    // Tiang kanan bawah
    glPushMatrix();
    glTranslatef(1.5f, 0.0f, -0.5f);
    glScalef(0.1f, 0.1f, 1.0f);
    glutSolidCube(1.0f);
    glPopMatrix();

    // Tiang bawah belakang
    glPushMatrix();
    glTranslatef(0.0f, 0.0f, -1.0f);
    glScalef(3.0f, 0.1f, 0.1f);
    glutSolidCube(1.0f);
    glPopMatrix();

    gambarnet();
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// Buat tanah/rumput
void gambartanah(float x, float y, float z, float scaleX, float scaleY, float scaleZ) {
    glPushMatrix();
    glColor3ub(0, 100, 0); // Warna hijau untuk lantai
    glTranslatef(x, y, z); // Posisi lantai
    glScalef(scaleX, scaleY, scaleZ); // Skala pada setiap sumbu
    glutSolidCube(1.0f); // Menggambar kubus
    glPopMatrix();
}

void display() {
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glLoadIdentity();
    gluLookAt(0.0, 3.0, 5.0, 
              0.0, 0.0, 0.0, 
              0.0, 1.0, 0.0);
    
    glPushMatrix();
    glScalef(globalScale, globalScale, globalScale); // Terapkan skala global

    glPushMatrix();
    glRotatef(rotationAngle, 0.0f, 0.01f, 0.0f);
    
   
    
    // Gambar garis kartesius di dalam transformasi yang sama dengan objek
    if (!hidden) {
        drawCartesius();
    }
    
    gambartianggawang();
    glPopMatrix();
    
    gambartanah(0, 0, 0, 10, 0.1, 10); // Menggambar tanah tipis 
    gambarBall();

    glPopMatrix();

    glutSwapBuffers();
}

void reshape(int w, int h) {
    glViewport(0, 0, w, h);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(45.0, (double)w / (double)h, 1.0, 100.0);  // Perspektif proyeksi
    glMatrixMode(GL_MODELVIEW);
}

// Fungsi untuk menangani input keyboard
void keyboard(unsigned char key, int x, int y) {
    switch (key) {
        case 'w': // Maju bola
            ballPosZ -= 0.1f;
            break;
        case 's': // Mundur bola
            ballPosZ += 0.1f;
            break;
        case 'a': // Kiri bola
            ballPosX -= 0.1f;
            break;
        case 'd': // Kanan bola
            ballPosX += 0.1f;
            break;
        case 'r': // Reset posisi bola
            ballPosX = 0.0f;
            ballPosY = 0.5f;
            ballPosZ = 2.5f;
            break;
        case 'p': // Pause atau lanjutkan rotasi
            isRotating = !isRotating;
            break;
        case 'c': // Toggle garis kartesius
            hidden = !hidden;
            break;
        case '+': // Perbesar semua objek
            globalScale += 0.5f;
            break;
        case '-': // Perkecil semua objek
            if (globalScale > 0.1f) globalScale -= 0.1f;
            break;
        case 27: // Escape untuk keluar
            exit(0);
            break;
    }
    glutPostRedisplay();
}

void updateRotation() {
    if (isRotating) {
        rotationAngle += 0.02f; // Kecepatan rotasi 
        if (rotationAngle > 360.0f) {
            rotationAngle -= 360.0f;
        }
    }
    glutPostRedisplay();
}

int main(int argc, char** argv) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowSize(800, 600);
    glutCreateWindow("Kelompok 8");

    init();
    glutDisplayFunc(display);
    glutReshapeFunc(reshape);
    glutKeyboardFunc(keyboard); // Menambahkan kontrol keyboard
    glutIdleFunc(updateRotation); // Fungsi untuk animasi rotasi otomatis
    glutMainLoop();
    return 0;
}
