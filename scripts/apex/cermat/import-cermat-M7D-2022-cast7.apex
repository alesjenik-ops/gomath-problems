String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD22C0T04';
Integer YEAR = 2022;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; String ccode; Integer yr; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype, String ccode, Integer yr){this.tx=tx;this.have=have;this.src=src;this.stype=stype;this.ccode=ccode;this.yr=yr;}
  Id sv(String t,String fn,String s){ContentVersion cv=new ContentVersion(Title=t,PathOnClient=fn,VersionData=Blob.valueOf(s),Origin='H');insert cv;return [SELECT ContentDocumentId FROM ContentVersion WHERE Id=:cv.Id].ContentDocumentId;}
  void lk(Id d,Id r){try{insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='AllUsers');}catch(Exception e){insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='InternalUsers');}}
  String para(String t){return '{"type":"paragraph","text":'+JSON.serialize(t)+'}';}
  String content(List<String> zad, Id d, String alt, String cap, List<String> opts, Integer ln){
    String s='{"schemaVersion":1,"blocks":[';
    for(Integer i=0;i<zad.size();i++){if(i>0)s+=',';s+=para(zad[i]);}
    if(d!=null){s+=',{"type":"image","contentDocumentId":"'+d+'","alt":'+JSON.serialize(alt)+',"caption":'+JSON.serialize(cap)+',"widthPercent":75,"align":"center"}';}
    if(opts!=null && !opts.isEmpty()){s+=',{"type":"list","items":[';for(Integer i=0;i<opts.size();i++){if(i>0)s+=',';s+=JSON.serialize(opts[i]);}s+=']}';}
    if(ln!=null && ln>0){s+=',{"type":"answerSpace","lines":'+ln+'}';}
    s+=']}';return s;
  }
  String solution(List<String> ps){String s='{"schemaVersion":1,"blocks":[';for(Integer i=0;i<ps.size();i++){if(i>0)s+=',';s+=para(ps[i]);}s+=']}';return s;}
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,CERMAT_Code__c=ccode,Source_Year__c=yr,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
    insert pub;
    List<Problem_Taxon__c> ls=new List<Problem_Taxon__c>();
    for(String code:codes){Id ti=tx.get(code);if(ti==null)continue;ls.add(new Problem_Taxon__c(Problem_Version__c=pub.Id,Taxon__c=ti,Unique_Key__c=pub.Id+'_'+ti));}
    if(!ls.isEmpty())insert ls;
    if(d!=null)lk(d,mp.Id);
    created++;
  }
}
Map<String,Id> tx=new Map<String,Id>();
for(Taxon__c t:[SELECT Id,Code__c FROM Taxon__c])tx.put(t.Code__c,t.Id);
Set<String> have=new Set<String>();
for(Math_Problem__c p:[SELECT Name FROM Math_Problem__c])have.add(p.Name);
C c=new C(tx,have,SRC,STYPE,CCODE,YEAR);

c.add(
  'CERMAT M7D 2022 – úloha 11',
  new List<String>{'Čtyřúhelník je rozdělen na dva tmavé rovnostranné trojúhelníky, jeden bílý čtyřúhelník a jeden bílý trojúhelník (viz obrázek). Vyznačené úhly mají velikost $41^\\circ$ a $36^\\circ$.','Jaká je velikost úhlu $\\varphi$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $105^\\circ$','B) $110^\\circ$','C) $115^\\circ$','D) $120^\\circ$','E) větší než $120^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 200" font-family="sans-serif" font-size="14"> <polygon points="30,150 150,120 250,58 360,58 260,150" fill="#fff" stroke="#000"/> <polygon points="150,120 250,58 260,150" fill="#9a9a9a" stroke="#000"/> <polygon points="250,58 360,58 260,150" fill="#9a9a9a" stroke="#000"/> <line x1="30" y1="150" x2="150" y2="120" stroke="#000"/> <line x1="150" y1="120" x2="260" y2="150" stroke="#000"/> <text x="58" y="146" font-size="12">41°</text> <text x="150" y="110" font-size="13">φ</text> <text x="160" y="134" font-size="12">36°</text> </svg>',
  'ctyruhelnik-uhly.svg',
  'Čtyřúhelník rozdělený na dva tmavé rovnostranné trojúhelníky, bílý čtyřúhelník a bílý trojúhelník; vyznačeny úhly 41 stupňů, 36 stupňů a hledaný úhel fí (schematicky).',
  'Schematický nákres k úloze 11',
  new List<String>{'Rovnostranné trojúhelníky mají všechny vnitřní úhly $60^\\circ$. Postupným dopočítáváním úhlů v jednotlivých trojúhelnících (součet vnitřních úhlů trojúhelníku je $180^\\circ$) a využitím přímých a vrcholových úhlů z daných hodnot $41^\\circ$ a $36^\\circ$ vyjde, že úhel $\\varphi$ je větší než $120^\\circ$.'},
  'E) větší než $120^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2022 – úloha 12',
  new List<String>{'Podstavou trojbokého kolmého hranolu je pravoúhlý trojúhelník, jehož dvě delší strany měří $17$ cm a $15$ cm. Výška hranolu je $5$ cm. Obě podstavy hranolu jsou tmavé, ostatní stěny jsou bílé. Ze čtyř těchto trojbokých hranolů je slepeno těleso (viz obrázek), které má dvě shodné stěny tmavé a zbývající čtyři stěny bílé.','Jaký obsah mají dohromady všechny bílé stěny slepeného tělesa?'},
  new List<String>{'A) menší než $300$ cm$^2$','B) $300$ cm$^2$','C) $330$ cm$^2$','D) $470$ cm$^2$','E) větší než $470$ cm$^2$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 200" font-family="sans-serif" font-size="13"> <polygon points="40,160 130,88 270,88 360,160" fill="#9a9a9a" stroke="#000"/> <polygon points="70,150 150,82 288,82 320,150" fill="none" stroke="#000"/> <line x1="40" y1="160" x2="70" y2="150" stroke="#000"/> <line x1="130" y1="88" x2="150" y2="82" stroke="#000"/> <line x1="270" y1="88" x2="288" y2="82" stroke="#000"/> <line x1="360" y1="160" x2="320" y2="150" stroke="#000"/> <line x1="130" y1="88" x2="130" y2="160" stroke="#000" stroke-dasharray="3 3"/> <line x1="270" y1="88" x2="270" y2="160" stroke="#000" stroke-dasharray="3 3"/> </svg>',
  'sleponove-teleso.svg',
  'Těleso ve tvaru lichoběžníkového hranolu slepené ze čtyř trojbokých hranolů (schematicky).',
  'Slepené těleso ze čtyř trojbokých hranolů',
  new List<String>{'Třetí strana podstavy je $\\sqrt{17^2-15^2}=\\sqrt{289-225}=\\sqrt{64}=8$ cm (odvěsny $15$ cm a $8$ cm, přepona $17$ cm).','Slepené těleso je hranol s podstavou rovnoramenného lichoběžníku (horní základna $15$ cm, dolní $45$ cm, ramena $17$ cm) a hloubkou $5$ cm. Bílé jsou čtyři obdélníkové stěny: dolní $45\\cdot 5=225$, horní $15\\cdot 5=75$ a dvě šikmé $17\\cdot 5=85$ každá. Celkem $225+75+2\\cdot 85=470$ cm$^2$.'},
  'D) $470$ cm$^2$',
  2, 5, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
