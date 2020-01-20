//Created by McCoy Zhu on September 5, 2019

void setup(){
  size(800,600);
  strokeJoin(ROUND);
  background(255);
}

void draw(){
  background(255);
  
  //left
  if ((mouseX * 5 + mouseY <= 2100 && mouseY <= 300)||(mouseX * 5 - mouseY <= 1750 && mouseY >= 300) || mouseY <= 100 || mouseY >= 500 || mouseX >=650 ){
    //face
    strokeWeight(10);
    fill(#19E35E);
    beginShape();
    vertex(150,500);
    vertex(150,100);
    vertex(400,100);
    vertex(360,300);
    vertex(410,300);
    vertex(450,500);
    vertex(150,500);
    endShape();
    
    //eye
    line(280,180,280,260);
    
    //smile
    strokeWeight(10);
    noFill();
    arc(400,170,500,500,1.44,PI-1);
  }
  
  //right
  if ((mouseX * 5 + mouseY >= 2100 && mouseY <= 300)||(mouseX * 5 - mouseY >= 1750 && mouseY >= 300)|| mouseY <= 100 || mouseY >= 500 || mouseX <= 150){
    //face
    strokeWeight(10);
    fill(#A7FFC5);
    beginShape();
    vertex(650,500);
    vertex(650,100);
    vertex(400,100);
    vertex(360,300);
    vertex(410,300);
    vertex(450,500);
    vertex(650,500);
    endShape();
    
    //eye
    line(520,180,520,260);
    
    //smile
    strokeWeight(10);
    noFill();
    arc(400,170,500,500,1,1.43);
  }  
  
  //text
  fill(0);
  textSize(24);
  textAlign(CENTER, DOWN);
  text("Hint: Try moving the cursor around!",400,40);
}
