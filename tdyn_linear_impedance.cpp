// #include <limits>
// #include <random>

/// ================================ MINE MINE MINE ===========================
#include <hiqp/utilities.h>
#include <hiqp/tasks/tdyn_linear_impedance.h>
#include <pluginlib/class_list_macros.h>

#include <ros/ros.h>

namespace hiqp{
  namespace tasks{

    TDynLinearImpedance::TDynLinearImpedance(
      std::shared_ptr<GeometricPrimitiveMap> geom_prim_map,
      std::shared_ptr<Visualizer> visualizer)
      : TDynPDController(geom_prim_map, visualizer) {}


    int TDynLinearImpedance::init(const std::vector<std::string> &parameters,
             RobotStatePtr robot_state,
             const Eigen::VectorXd &e_initial,
             const Eigen::VectorXd &e_dot_initial,
             const Eigen::VectorXd &e_final,
             const Eigen::VectorXd &e_dot_final){

       int dim = e_initial.rows();   ///< number of controlled dimensions
       int size = parameters.size(); ///< number of given parameters

       // ensure consistency
       assert((e_dot_initial.rows() == dim) && (e_final.rows() == dim) &&
              (e_dot_final.rows() == dim));


      /*! \brief It is assumed that the two gain matrices Kp & Kd in R^{m x m}
       * are given subsequently in row-major format in the parameter string,
       * i. e., Kp_ = parameters[1] - parameters[m^2],
       * and Kd_ = parameters[m^2+1] - parameters[2*m^2],
       * where m is the task space dimension
       * \author Robert
       */


      /*  ensure that valid parameters are given
       *  [0] : Controller name,  [1] : K_p , [2] : K_d , [3]: B
       */

      if ((size != 3 * dim * dim + 1) && (size != 4)) {
        printHiqpWarning("TDynLinearImpedance for a " + std::to_string(dim) +
                         "-dimensional task requires either " +
                         std::to_string(3 * dim * dim + 1) +
                         " or 4 parameters, got " + std::to_string(size) +
                         "! Initialization failed!");
        return -1;
      }

/* ============================================================================
====== !!!!!!! FOR THE TIME BEING, SCALAR VALUES ARE CONSIDERED ================
====== !!!!!!! ONLY SIZE == 4 CASE IS VIABLE, NEED TO CHANGE IT ===============

*/
      // read the gains and the desired inertia matrix
      k_p_ = std::stod(parameters.at(1));
      k_d_ = std::stod(parameters.at(2));
      float B = std::stod(parameters.at(3));
      // B_inv_ = pinv(B); //uncomment when you get the inertia MATRIX
      B_inv_ = 1/B;
      // // initialize the controller through initialization of the base class
      // if (TDynPDController::init(tdyn_pd_parameters, robot_state, e_dot_initial,
      //                            e_dot_initial, e_final, e_dot_final) != 0){
      //                              return -1;
      //                            }
      return 0;
    }


  int TDynLinearImpedance::update(const RobotStatePtr robot_state,
                                  const std::shared_ptr<TaskDefinition> def) {
      // System equation
      e_ddot_star_ =  B_inv_ * (-k_p_ * def->getTaskValue() - k_d_ * def->getTaskDerivative() +
                      def->getExogeneousTaskQuantities());
      return 0;
     }

  int TDynLinearImpedance::monitor() { return 0; }




          } // ns tasks
} // ns hiqp
PLUGINLIB_EXPORT_CLASS(hiqp::tasks::TDynLinearImpedance, hiqp::tasks::TDynPDController)
