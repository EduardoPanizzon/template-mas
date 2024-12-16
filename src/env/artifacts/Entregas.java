package artifacts;

import java.awt.event.ActionEvent;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

import cartago.*;
import cartago.tools.GUIArtifact;

public class Entregas extends GUIArtifact {

    private InterfaceEntregas frame;

    public void setup() {
        create_frame();
    }

    void create_frame() {
        frame = new InterfaceEntregas();
        linkActionEventToOp(frame.okButton, "ok");
        frame.setVisible(true);
    }

    @INTERNAL_OPERATION
    void ok(ActionEvent ev) {
        // Recupera os valores inseridos na interface gráfica
        String pacote = frame.getPacote();
        String origem = frame.getOrigem(); 
        String destino = frame.getDestino();

        String[] origemXY = origem.split(",");
		String[] destinoXY = destino.split(",");

		int xo = Integer.parseInt(origemXY[0]);
		int yo = Integer.parseInt(origemXY[1]);
		int xd = Integer.parseInt(destinoXY[0]);
		int yd = Integer.parseInt(destinoXY[1]);

		defineObsProperty("pacote", pacote, xo, yo, xd, yd);
		
        // Envia o sinal com os valores no formato desejado
        signal("sinal");

        // Opcional: Exibe no console para confirmação
        System.out.println("Pacote adicionado: pacote(" + pacote + ", origem(" + xo + ", " + yo + ")), destino(" + xd + ", " + yd + "))");
    }

    class InterfaceEntregas extends JFrame {

        private JButton okButton;
        private JTextField pacoteS;
        private JTextField origemS;
        private JTextField destinoS;

        public InterfaceEntregas() {
            setTitle("Adicionar Pacote");
            setSize(200, 300);

            JPanel panel = new JPanel();
            JLabel add = new JLabel("Adicionar pacote");
            JLabel pacote = new JLabel("Pacote: ");
            JLabel origem = new JLabel("Origem: ");
            JLabel destino = new JLabel("Destino: ");
            setContentPane(panel);

            okButton = new JButton("OK");
            okButton.setSize(80, 50);

            pacoteS = new JTextField(10);
            pacoteS.setText("Pacote");
            pacoteS.setEditable(true);

            origemS = new JTextField(10);
            origemS.setText("25,25");
            origemS.setEditable(true);

            destinoS = new JTextField(10);
            destinoS.setText("35,35");
            destinoS.setEditable(true);

            panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));
            panel.add(add);
            panel.add(pacote);
            panel.add(pacoteS);
            panel.add(origem);
            panel.add(origemS);
            panel.add(destino);
            panel.add(destinoS);
            panel.add(okButton);
        }

        public String getPacote() {
            return pacoteS.getText();
        }

        public String getDestino() {
            return destinoS.getText();
        }

        public String getOrigem() {
            return origemS.getText();
        }
    }
}
